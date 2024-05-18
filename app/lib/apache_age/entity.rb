module ApacheAge
  class Entity
    class << self
      def find_by(attributes)
        where_clause = attributes.map { |k, v| "find.#{k} = '#{v}'" }.join(' AND ')
        handle_find(where_clause)
      end

      def find(id)
        where_clause = "id(find) = #{id}"
        handle_find(where_clause)
      end

      private

      def age_graph = 'age_schema'

      def handle_find(where_clause)
        # try to find a vertex
        match_node = '(find)'
        cypher_sql = find_sql(match_node, where_clause)
        age_response = execute_find(cypher_sql)

        if age_response.nil?
          # if not a vertex try to find an edge
          match_edge = '()-[find]->()'
          cypher_sql = find_sql(match_edge, where_clause)
          age_response = execute_find(cypher_sql)
          return nil if age_response.nil?
        end

        instantiate_result(age_response)
      end

      def execute_find(cypher_sql)
        age_result = ActiveRecord::Base.connection.execute(cypher_sql)
        return nil if age_result.values.first.nil?

        age_result
      end

      def instantiate_result(age_response)
        age_type = age_response.values.first.first.split('::').last
        json_data = age_response.values.first.first.split('::').first

        hash = JSON.parse(json_data)
        attribs = hash.except('label', 'properties').merge(hash['properties']).symbolize_keys

        # TODO: fix so it works with or without the namespace!
        if age_type == 'vertex'
          "Nodes::#{hash['label']}".constantize.new(**attribs)
        else
          "Edges::#{hash['label']}".constantize.new(**attribs)
        end
      end

      def find_sql(match_clause, where_clause)
        <<-SQL
          SELECT *
          FROM cypher('#{age_graph}', $$
              MATCH #{match_clause}
              WHERE #{where_clause}
              RETURN find
          $$) as (found agtype);
        SQL
      end
    end
  end
end
