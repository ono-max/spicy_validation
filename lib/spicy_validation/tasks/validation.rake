# frozen_string_literal: true

namespace :validation do
  desc "Generate validations from database schema"
  task generate: :environment do
    require "spicy_validation/renderer"
    dry_run = %w[true 1 on].include? ENV["DRY_RUN"]
    SpicyValidation::Renderer.generate(dry_run: dry_run)
  end
end
