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
RSpec.describe SpicyValidation::Validation do
  describe "normal_validations" do
    subject { described_class.normal_validations(table_name: "users") }
    context "column is {null: false}" do
      include_context "add_column", :name, :string, null: false, default: ""
      it {
        is_expected.to include have_attributes(method_name: "validates", column_name: :name,
                                               options: { presence: true })
      }
    end
    context "column type is nullable integer" do
      include_context "add_column", :age, :integer
      it {
        is_expected.to include have_attributes(method_name: "validates", column_name: :age,
                                               options: { numericality: true, allow_nil: true })
      }
    end
    context "column type is not null integer" do
      include_context "add_column", :score, :integer, null: false, default: 0
      it {
        is_expected.to include have_attributes(method_name: "validates", column_name: :score,
                                               options: { numericality: true, presence: true })
      }
    end
  end
  describe "unique_validations" do
    subject { described_class.unique_validations(table_name: "users") }
    include_context "add_column", :name, :string, null: false, default: ""
    include_context "add_column", :age, :integer
    include_context "add_column", :premium, :boolean
    context "add index a column" do
      include_context "add_index", :name, unique: true
      it { is_expected.to include have_attributes(method_name: "validates_uniqueness_of", column_name: :name) }
    end
    context "add index to two columns" do
      include_context "add_index", %i[name age], unique: true
      it {
        is_expected.to include have_attributes(method_name: "validates_uniqueness_of", column_name: :name,
                                               options: { scope: :age })
      }
    end
    context "add index to three columns" do
      include_context "add_index", %i[name age premium], unique: true
      it {
        is_expected.to include have_attributes(method_name: "validates_uniqueness_of", column_name: :name,
                                               options: { scope: %i[age premium] })
      }
    end
  end
  describe "to_s" do
    subject { described_class.new(method_name: method_name, column_name: column_name, options: options).to_s }
    context "options is blank" do
      let(:method_name) { "validates_uniqueness_of" }
      let(:column_name) { :name }
      let(:options) { nil }
      it { is_expected.to eq "validates_uniqueness_of :name" }
    end
    context "options is single" do
      let(:method_name) { "validates" }
      let(:column_name) { :name }
      let(:options) { { presence: true } }
      it { is_expected.to eq "validates :name, presence: true" }
    end
    context "options are multiple" do
      let(:method_name) { "validates" }
      let(:column_name) { :age }
      let(:options) { { presence: true, numericality: true } }
      it { is_expected.to eq "validates :age, presence: true, numericality: true" }
    end
  end
end
