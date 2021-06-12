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
