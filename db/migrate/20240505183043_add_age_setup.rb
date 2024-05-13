class AddAgeSetup < ActiveRecord::Migration[7.1]
  def change
    # allow age extension
    execute("CREATE EXTENSION IF NOT EXISTS age;")
    # load the age code
    execute("LOAD 'age';")
    # load the ag_catalog into the search path
    execute('SET search_path = ag_catalog, "$user", public;')

    # creates our AGE schema
    # USE: `execute("SELECT create_graph('age_schema');")`, as we need to use: `create_graph`
    # NOT: `ActiveRecord::Base.connection.create_schema('age_schema')`
    execute("SELECT create_graph('age_schema');")
  end
end
