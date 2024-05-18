module ApacheAge
  module CommonMethods
    def initialize(**attributes)
      super
      return self unless age_type == 'edge'

      self.end_id ||= end_node.id if end_node
      self.start_id ||= start_node.id if start_node
      self.end_node ||= ApacheAge::Entity.find(end_id) if end_id
      self.start_node ||= ApacheAge::Entity.find(start_id) if start_id
    end

    def persisted? = id.present?
    # for now we just can just use one schema
    def age_graph = 'age_schema'
    def age_label = self.class.name.split('::').last
    def to_s = ":#{age_label} #{properties_to_s}"

    def update(attribs)
      attribs.except(id:).each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end

    def save
      response_hash = id.present? ? execute_sql(update_sql) : execute_sql(create_sql)

      self.id = response_hash['id']

      if age_type == 'edge'
        self.end_id = response_hash['end_id']
        self.start_id = response_hash['start_id']
        # reload the nodes?
        # self.end_node = Age::Nodes.find(end_id)
        # self.start_node = Age::Nodes.find(start_id)
      end

      self
    end

    def destroy
      match_clause = (age_type == 'vertex' ? "(done:#{age_label})" : "[done:#{age_label}]")
      where_clause = (age_type == 'vertex' ? "id(done) = #{id}" : "id[done] = #{id}")
      delete_clause = (age_type == 'vertex' ? 'DETACH DELETE done' : 'DELETE done')
      cypher_sql =
        <<-SQL
        SELECT *
        FROM cypher('#{age_graph}', $$
            MATCH #{match_clause}
            WHERE #{where_clause}
 	          #{delete_clause}
            return done
        $$) as (deleted agtype);
        SQL

      hash = execute_sql(cypher_sql)
      return nil if hash.blank?

      attribs = hash.except('id', 'label', 'properties')
                    .merge(hash['properties'])
                    .symbolize_keys

      # TODO: fix so it works with or without the namespace!
      if age_type == 'vertex'
        "Nodes::#{hash['label']}".constantize.new(**attribs)
      else
        "Edges::#{hash['label']}".constantize.new(**attribs)
      end
    end

    def to_h
      base_h = attributes.to_hash
      if age_type == 'edge'
        base_h = base_h.except('start_node', 'end_node')
        base_h['start_node'] = start_node.to_h
        base_h['end_node'] = end_node.to_h
      end
      base_h.with_indifferent_access
    end

    def age_properties
      attrs = attributes.except('id')
      attrs = attrs.except('end_node', 'start_node', 'end_id', 'start_id') if age_type == 'edge'
      attrs.symbolize_keys
    end

    def age_hash
      hash =
        {
          id:,
          label: age_label,
          properties: age_properties
        }
      hash.merge!(end_id:, start_id:) if age_type == 'edge'
      hash.transform_keys(&:to_s)
    end

    def properties_to_s
      string_values =
        age_properties.each_with_object([]) do |(key, val), array|
          array << "#{key}: '#{val}'"
        end
      "{#{string_values.join(', ')}}"
    end

    def age_alias
      return nil if id.blank?

      # we start the alias with a since we can't start with a number
      'a' + Digest::SHA256.hexdigest(id.to_s).to_i(16).to_s(36)[0..9]
    end

    def execute_sql(cypher_sql)
      age_result = ActiveRecord::Base.connection.execute(cypher_sql)
      age_type = age_result.values.first.first.split('::').last
      json_data = age_result.values.first.first.split('::').first
      # json_data = age_result.to_a.first.values.first.split("::#{age_type}").first

      JSON.parse(json_data)
    end
  end
end