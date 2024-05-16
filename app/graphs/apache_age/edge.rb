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

    def age_type = 'edge'

    # AgeSchema::Edges::WorksAt.create(
    #   start_node: fred, end_node: quarry, employee_role: 'Crane Operator'
    # )
    # SELECT *
    # FROM cypher('age_schema', $$
    #     MATCH (start_vertex:Person), (end_vertex:Company)
    #     WHERE id(start_vertex) = 1125899906842634 and id(end_vertex) = 844424930131976
    #     CREATE (start_vertex)-[edge:WorksAt {employee_role: 'Crane Operator'}]->(end_vertex)
    #     RETURN edge
    # $$) as (edge agtype);
    def create_sql
      self.start_node = start_node.save unless start_node.persisted?
      self.end_node = end_node.save unless end_node.persisted?
      <<-SQL
        SELECT *
        FROM cypher('#{age_graph}', $$
            MATCH (start:#{start_node.age_label}), (end:#{end_node.age_label})
            WHERE id(start) = #{start_node.id} and id(end) = #{end_node.id}
            CREATE (start)-[edge#{self}]->(end)
            RETURN edge
        $$) as (edge agtype);
      SQL
    end
  end
end
