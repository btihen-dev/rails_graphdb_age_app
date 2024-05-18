# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_505_183_043) do
  execute('CREATE EXTENSION IF NOT EXISTS age;')
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

  # These are extensions that must be enabled in order to support this database
  enable_extension 'age'
  enable_extension 'plpgsql'

  # Load the age code
  execute("LOAD 'age';")

  # Load the ag_catalog into the search path
  execute('SET search_path = ag_catalog, "$user", public;')

  execute <<-SQL
    DO $$
    BEGIN
      IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'fk_graph_oid'
      ) THEN
        ALTER TABLE ag_label ADD CONSTRAINT fk_graph_oid FOREIGN KEY (graph) REFERENCES ag_graph (graphid);
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
  #       ALTER TABLE ag_catalog.ag_label
  #       ADD CONSTRAINT fk_graph_oid FOREIGN KEY (graph)
  #       REFERENCES ag_catalog.ag_graph (graphid);
  #     END IF;
  #   END $$;
  # SQL

  # create_schema 'age_schema'
  execute <<-SQL
    DO $$
    BEGIN
      IF NOT EXISTS (
        SELECT 1
        FROM ag_catalog.ag_graph
        WHERE name = 'age_schema'
      ) THEN
        PERFORM create_graph('age_schema');
      END IF;
    END $$;
  SQL
end
