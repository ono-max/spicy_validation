# frozen_string_literal: true

require "spec_helper"

using NewHashSyntax

RSpec.describe NewHashSyntax do
  describe "#format" do
    context "{a: 1}.format" do
      subject { { a: 1 }.format_hash }
      it { is_expected.to eq "a: 1" }
    end
  end
end
