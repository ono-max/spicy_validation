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
