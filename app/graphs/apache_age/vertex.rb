module ApacheAge
  module Vertex
    extend ActiveSupport::Concern
    include ApacheAge::Entity

    included do
      include ActiveModel::Model
      include ActiveModel::Dirty
      include ActiveModel::Attributes

      attribute :id, :integer

      extend ApacheAge::ClassMethods
    end

    def age_type = 'vertex'
    def to_h = base_to_h.symbolize_keys
    def age_properties = base_properties.symbolize_keys
    def age_hash = base_hash.with_indifferent_access

    # for now only does a create
    def save
      return self if id.present?

      response_hash = execute_sql
      self.id = response_hash['id']

      self
    end

    def create_sql
      alias_name = age_alias || age_label.downcase
      <<-SQL
        SELECT *
        FROM cypher('#{age_graph}', $$
            CREATE (#{alias_name}#{self})
        RETURN #{alias_name}
        $$) as (#{age_label} agtype);
      SQL
    end
  end
end
