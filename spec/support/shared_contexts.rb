# frozen_string_literal: true

RSpec.shared_context "add_column" do |column, type, options = {}|
  kclass = Class.new(ActiveRecord::Migration[6.0]) do
    class_eval <<-MIGRATION, __FILE__, __LINE__ + 1
      def self.up
        add_column :users, #{column.inspect}, #{type.inspect}, #{options.inspect}
      end
      def self.down
        remove_column :users, #{column.inspect}
      end
    MIGRATION
  end

  before { kclass.up }
  after { kclass.down }
end
RSpec.shared_context "add_index" do |column, options = {}|
  kclass = Class.new(ActiveRecord::Migration[6.0]) do
    class_eval <<-MIGRATION, __FILE__, __LINE__ + 1
      def self.up
        add_index :users, #{column.inspect}, #{options.inspect}
      end
      def self.down
        remove_index :users, #{column.inspect}
      end
    MIGRATION
  end

  before { kclass.up }
  after { kclass.down }
end
