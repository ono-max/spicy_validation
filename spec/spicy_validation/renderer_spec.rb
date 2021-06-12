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

require "spec_helper"
RSpec.describe SpicyValidation::Renderer do
  describe "content" do
    subject { described_class.new(table_name: "users").content }
    include_context "add_column", :name, :string, null: false, default: ""
    include_context "add_column", :age, :integer
    include_context "add_column", :score, :integer, null: false, default: 0
    include_context "add_column", :premium, :boolean
    include_context "add_index", :name, unique: true
    include_context "add_index", %i[name age], unique: true
    include_context "add_index", %i[name age premium], unique: true
    let(:expected_result) do
      <<~MODEL
        class User < ApplicationRecord
          validates :name, presence: true
          validates :age, numericality: true, allow_nil: true
          validates :score, presence: true, numericality: true
          validates_uniqueness_of :name
          validates_uniqueness_of :name, scope: :age
          validates_uniqueness_of :name, scope: [:age, :premium]
        end
      MODEL
    end
    it { is_expected.to eq expected_result }
  end
end
