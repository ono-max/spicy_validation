# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  username: "root",
  password: "root",
  database: "sample"
)
class CreateAllTables < ActiveRecord::Migration[6.0]
  def self.up
    create_table ActiveRecord::SchemaMigration.table_name do |t|
      t.string :version, null: false
    end

    create_table :users
  end
end
CreateAllTables.up unless ActiveRecord::Base.connection.table_exists?(:users)
ActiveRecord::Migration.verbose = false
