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

ActiveRecord::Schema[7.1].define(version: 2024_05_05_183043) do
  create_schema "ag_catalog"
  create_schema "age_schema"

  # These are extensions that must be enabled in order to support this database
  enable_extension "age"
  enable_extension "plpgsql"

# Could not dump table "_ag_label_edge" because of following StandardError
#   Unknown type 'graphid' for column 'id'

# Could not dump table "_ag_label_vertex" because of following StandardError
#   Unknown type 'graphid' for column 'id'

# Could not dump table "ag_graph" because of following StandardError
#   Unknown type 'regnamespace' for column 'namespace'

# Could not dump table "ag_label" because of following StandardError
#   Unknown type 'regclass' for column 'relation'

  add_foreign_key "ag_label", "ag_graph", column: "graph", primary_key: "graphid", name: "fk_graph_oid"
end
