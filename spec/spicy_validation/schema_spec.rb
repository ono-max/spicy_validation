# frozen_string_literal: true

require "spec_helper"
RSpec.describe SpicyValidation::Schema do
  describe "table_names" do
    subject { described_class.table_names }
    it { is_expected.to contain_exactly "users" }
  end
end
