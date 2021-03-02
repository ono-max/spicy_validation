# frozen_string_literal: true

module SpicyValidation
  class Railtie < Rails::Railtie
    rake_tasks do
      load "spicy_validation/tasks/validation.rake"
    end
  end
end
