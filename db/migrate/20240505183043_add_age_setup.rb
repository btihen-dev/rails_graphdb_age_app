class AddAgeSetup < ActiveRecord::Migration[7.1]
  def change
    # allow age extension
    execute('CREATE EXTENSION IF NOT EXISTS age;')
    # load the age code
    execute("LOAD 'age';")
    # load the ag_catalog into the search path
    execute('SET search_path = ag_catalog, "$user", public;')

    # creates our AGE schema
    # USE: `execute("SELECT create_graph('age_schema');")`, as we need to use: `create_graph`
    # NOT: `ActiveRecord::Base.connection.create_schema('age_schema')`
    execute("SELECT create_graph('age_schema');")
    # execute("SELECT create_graph('age_schema') IF NOT EXISTS (SELECT 1 FROM pg_namespace WHERE nspname = 'age_schema');")

    # add_foreign_key(
    #   'ag_catalog.ag_label', 'ag_catalog.ag_graph',
    #   column: 'graph', primary_key: 'graphid',
    #   name: 'fk_graph_oid', if_not_exists: true
    # )
    # add foreign key constraint to ag_catalog.ag_label table
    # return if foreign_key_exists?('ag_catalog.ag_label', 'ag_catalog.ag_graph', column: 'graph', name: 'fk_graph_oid')

    # add_foreign_key(
    #   'ag_catalog.ag_label', 'ag_catalog.ag_graph',
    #   column: 'graph', primary_key: 'graphid', name: 'fk_graph_oid'
    # )

    # return if foreign_key_exists?('ag_catalog.ag_label', 'ag_catalog.ag_graph', column: 'graph', name: 'fk_graph_oid')
    # add_foreign_key(
    #   'ag_catalog.ag_label', 'ag_catalog.ag_graph',
    #   column: 'graph', primary_key: 'graphid', name: 'fk_graph_oid'
    # )
    # drop the foreign key constraint if it exists
    # if foreign_key_exists?('ag_catalog.ag_label', 'ag_catalog.ag_graph', column: 'graph', name: 'fk_graph_oid')
    #   execute('ALTER TABLE ag_catalog.ag_label DROP CONSTRAINT fk_graph_oid;')
    # end

    # # add the foreign key constraint
    # add_foreign_key(
    #   'ag_catalog.ag_label', 'ag_catalog.ag_graph',
    #   column: 'graph', primary_key: 'graphid', name: 'fk_graph_oid'
    # )
  end
end
