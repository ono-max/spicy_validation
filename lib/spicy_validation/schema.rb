# frozen_string_literal: true

module SpicyValidation
  class Schema
    def self.table_names
      abstract_tables = [ActiveRecord::SchemaMigration.table_name, ActiveRecord::InternalMetadata.table_name]
      ActiveRecord::Base
        .connection.tables
        .delete_if { |t| abstract_tables.include?(t) }
    end

    def self.columns(table_name:)
      ActiveRecord::Base.connection.columns(table_name)
    end

    def self.indexes(table_name:)
      ActiveRecord::Base.connection.indexes(table_name)
    end
  end
end
