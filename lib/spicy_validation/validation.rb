# frozen_string_literal: true

#
# The following codes based on https://github.com/sinsoku/pretty_validation
#
# The MIT License (MIT)
# 
# Copyright (c) 2015 sinsoku
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

require_relative "monkey/new_hash_syntax"
module SpicyValidation
  class Validation
    using NewHashSyntax
    attr_reader :method_name, :column_name, :options

    def initialize(method_name:, column_name:, options:)
      @method_name = method_name
      @column_name = column_name
      @options = options
    end

    def self.normal_validations(table_name:)
      columns = Schema.columns(table_name: table_name)
      columns = columns.reject { |x| x.name.in? %w[id created_at updated_at] }
      columns.map do |column|
        options = {}
        options[:presence] = true unless column.null
        options[:numericality] = true if column.type == :integer
        options[:allow_nil] = true if column.null && (column.type == :integer)
        Validation.new(method_name: "validates", column_name: column.name.to_sym, options: options) if options.present?
      end.compact
    end

    def self.unique_validations(table_name:)
      Schema.indexes(table_name: table_name).map do |index|
        column_name = index.columns[0]
        scope = index.columns[1..-1].map(&:to_sym)
        options = if scope.size > 1
                    { scope: scope }
                  elsif scope.size == 1
                    { scope: scope[0] }
                  end
        Validation.new(method_name: "validates_uniqueness_of", column_name: column_name.to_sym, options: options)
      end
    end

    def to_s
      if options.blank?
        "#{method_name} #{column_name.inspect}"
      else
        "#{method_name} #{column_name.inspect}, #{options.format_hash}"
      end
    end
  end
end
