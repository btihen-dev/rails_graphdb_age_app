module ApacheAge
  module Edge
    extend ActiveSupport::Concern
    include ApacheAge::Entity

    included do
      include ActiveModel::Model
      include ActiveModel::Dirty
      include ActiveModel::Attributes

      attribute :id, :integer
      attribute :end_id, :integer
      attribute :start_id, :integer
      attribute :end_node # :vertex
      attribute :start_node # :vertex

      extend ApacheAge::ClassMethods
    end

    def initialize(**attributes)
      super
      self.end_id ||= end_node.id
      self.start_id ||= start_node.id
    end

    def age_type = 'edge'
    def age_hash = base_hash.merge(end_id:, start_id:)
    def age_properties = base_properties.except('start_node', 'end_node', 'start_id', 'end_id').symbolize_keys

    def to_h
      base_h = base_to_h.except('start_node', 'end_node')
      base_h['start_node'] = start_node.to_h
      base_h['end_node'] = end_node.to_h
      base_h.with_indifferent_access
    end

    # for now only does a create
    def save
      return self if id.present?

      response_hash = execute_sql
      self.id = response_hash['id']
      self.end_id = response_hash['end_id']
      self.start_id = response_hash['start_id']

      self
    end

    def create_sql
      self.start_node = start_node.save unless start_node.persisted?
      self.end_node = end_node.save unless end_node.persisted?
      <<-SQL
        SELECT *
        FROM cypher('#{age_graph}', $$
            MATCH (start_vertex:#{start_node.age_label}), (end_vertex:#{end_node.age_label})
            WHERE id(start_vertex) = #{start_node.id} and id(end_vertex) = #{end_node.id}
            CREATE (start_vertex)-[edge#{to_s}]->(end_vertex)
            RETURN edge
        $$) as (edge agtype);
      SQL
    end
  end
end
