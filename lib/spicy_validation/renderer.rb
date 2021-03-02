# frozen_string_literal: true

require_relative "validation"
require_relative "schema"

module SpicyValidation
  class Renderer
    attr_reader :table_name

    def initialize(table_name:)
      @table_name = table_name
    end

    def self.generate(dry_run: false)
      table = choose_table_name
      object_table = new(table_name: table)
      return if object_table.validations.empty?

      object_table.write! if generate?(dry_run: dry_run)
    end

    def write!
      File.write(model_path, content)
    end

    def self.generate?(dry_run:)
      !dry_run
    end

    def self.choose_table_name
      puts "\e[33m[warning] If you generate validation, model file will be overwritten.\e[0m"
      hash_tables = Schema.table_names.map.with_index { |table, index| [index.to_s.to_sym, table] }.to_h
      p hash_tables
      while true
        print "Type a number you wanna generate validation > "
        num = $stdin.gets.chomp.to_sym
        break if hash_tables.key?(num)

        p "Type a number correctly!"
      end

      hash_tables[num]
    end

    def validations
      normal_validations + unique_validations
    end

    def content
      <<~MODEL
        class #{model_name} < ApplicationRecord
          #{validations.join("\n  ")}
        end
      MODEL
    end

    def model_name
      table_name.classify
    end

    private

    def normal_validations
      Validation.normal_validations(table_name: table_name)
    end

    def unique_validations
      Validation.unique_validations(table_name: table_name)
    end

    def model_path
      File.join(Rails.root.glob("app/models/**/#{model_name.downcase}.rb"))
    end
  end
end
