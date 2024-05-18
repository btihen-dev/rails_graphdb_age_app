class AddAgeSetup < ActiveRecord::Migration[7.1]
  def up
    # Allow age extension
    execute('CREATE EXTENSION IF NOT EXISTS age;')

    # Load the age code
    execute("LOAD 'age';")

    # Load the ag_catalog into the search path
    execute('SET search_path = ag_catalog, "$user", public;')

    # Create ag_catalog schema if it doesn't exist (should be done when extension is added)
    execute <<-SQL
      DO $$
      BEGIN
        IF NOT EXISTS (
          SELECT 1
          FROM pg_namespace
          WHERE nspname = 'ag_catalog'
        ) THEN
          CREATE SCHEMA ag_catalog;
        END IF;
      END $$;
    SQL

    # Add foreign key constraint if it doesn't exist (should be done when extension is added)
    execute <<-SQL
      DO $$
      BEGIN
        IF NOT EXISTS (
          SELECT 1
          FROM pg_constraint
          WHERE conname = 'fk_graph_oid'
        ) THEN
          ALTER TABLE ag_catalog.ag_label
          ADD CONSTRAINT fk_graph_oid FOREIGN KEY (graph)
          REFERENCES ag_catalog.ag_graph (graphid);
        END IF;
      END $$;
    SQL
    # execute <<-SQL
    #   DO $$
    #   BEGIN
    #     IF NOT EXISTS (
    #       SELECT 1
    #       FROM pg_constraint
    #       WHERE conname = 'fk_graph_oid'
    #     ) THEN
    #       ALTER TABLE ag_label ADD CONSTRAINT fk_graph_oid FOREIGN KEY (graph) REFERENCES ag_graph (graphid);
    #     END IF;
    #   END $$;
    # SQL

    # Create age_schema graph if it doesn't exist
    execute("SELECT create_graph('age_schema');")
    # execute("SELECT * FROM ag_catalog.create_graph('graph_name');")
    # execute <<-SQL
    #   DO $$
    #   BEGIN
    #     IF NOT EXISTS (
    #       SELECT 1
    #       FROM ag_catalog.ag_graph
    #       WHERE name = 'age_schema'
    #     ) THEN
    #       PERFORM create_graph('age_schema');
    #     END IF;
    #   END $$;
    # SQL
  end

  def down
    execute <<-SQL
      DO $$
      BEGIN
        IF EXISTS (
          SELECT 1
          FROM pg_constraint
          WHERE conname = 'fk_graph_oid'
        ) THEN
          ALTER TABLE ag_catalog.ag_label
          DROP CONSTRAINT fk_graph_oid;
        END IF;
      END $$;
    SQL

    execute("SELECT drop_graph('age_schema', true);")
    execute('DROP SCHEMA IF EXISTS ag_catalog CASCADE;')
    execute('DROP EXTENSION IF EXISTS age;')
  end
end
