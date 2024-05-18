module ApacheAge
  module ClassMethods
    # for now we only allow one predertimed graph
    def age_graph = 'age_schema'
    # class name always represent the graph label
    def age_label = name.split('::').last
    # the penultimate part of the name always represent the graph type
    def age_type = (name.split('::')[-2] == 'Edges' ? 'edge' : 'vertex')

    def create(**attributes) = new(**attributes).save

    def find_by(attributes)
      where_clause = attributes.map { |k, v| "find.#{k} = '#{v}'" }.join(' AND ')
      cypher_sql = find_sql(where_clause)
      execute_find(cypher_sql)
    end

    def find(id)
      where_clause = "id(find) = #{id}"
      cypher_sql = find_sql(where_clause)
      execute_find(cypher_sql)
    end

    def match_clause
      age_type == 'vertex' ? "(find:#{age_label})" : "()-[find:#{age_label}]->()"
    end

    def all
      age_results = ActiveRecord::Base.connection.execute(all_sql)
      return [] if age_results.values.count.zero?

      age_results.values.map do |result|
        json_string = result.first.split('::').first
        hash = JSON.parse(json_string)
        attribs = hash.except('label', 'properties').merge(hash['properties']).symbolize_keys
        # TODO: fix so it works with or without the namespace!
        if age_type == 'vertex'
          "Nodes::#{hash['label']}".constantize.new(**attribs)
        else
          "Edges::#{hash['label']}".constantize.new(**attribs)
        end
      end
    end

    # Private stuff

    def execute_find(cypher_sql)
      age_result = ActiveRecord::Base.connection.execute(cypher_sql)
      return nil if age_result.values.count.zero?

      age_type = age_result.values.first.first.split('::').last
      json_data = age_result.values.first.first.split('::').first

      hash = JSON.parse(json_data)
      attribs = hash.except('label', 'properties').merge(hash['properties']).symbolize_keys
      # TODO: fix so it works with or without the namespace!
      if age_type == 'vertex'
        "Nodes::#{hash['label']}".constantize.new(**attribs)
      else
        "Edges::#{hash['label']}".constantize.new(**attribs)
      end
    end

    def all_sql
      <<-SQL
      SELECT *
      FROM cypher('#{age_graph}', $$
          MATCH #{match_clause}
          RETURN find
      $$) as (#{age_label} agtype);
      SQL
    end

    def find_sql(where_clause)
      <<-SQL
        SELECT *
        FROM cypher('#{age_graph}', $$
            MATCH #{match_clause}
            WHERE #{where_clause}
            RETURN find
        $$) as (#{age_label} agtype);
      SQL
    end
  end
end
