# frozen_string_literal: true

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
