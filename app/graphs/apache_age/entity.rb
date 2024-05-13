module ApacheAge
  module Entity
    def age_label = self.class.name.split('::').last
    def age_graph = self.class.name.split('::').first.underscore
    def persisted? = id.present?
    def to_s = ":#{age_label} #{properties_to_s}"
    def base_to_h = attributes.to_hash
    def base_properties = attributes.except('id')

    def base_hash
      {
        id: id,
        label: age_label,
        properties: age_properties
      }.transform_keys(&:to_s)
    end

    def properties_to_s
      string_values =
        age_properties.each_with_object([]) do |(key,val), array|
          array << "#{key}: '#{val}'"
        end
      "{#{string_values.join(', ')}}"
    end

    def age_alias
      return nil if id.blank?

      # we start the alias with a since we can't start with a number
      'a' + Digest::SHA256.hexdigest(id.to_s).to_i(16).to_s(36)[0..9]
    end

    def execute_sql
      return self.age_hash if id.present?

      age_result = ActiveRecord::Base.connection.execute(create_sql)
      json_data = age_result.to_a.first.values.first.split("::#{age_type}").first

      JSON.parse(json_data)
    end
  end
end
