# frozen_string_literal: true

require_relative "lib/spicy_validation/version"

Gem::Specification.new do |spec|
  spec.name          = "spicy_validation"
  spec.version       = SpicyValidation::VERSION
  spec.authors       = ["Naoto Ono"]
  spec.email         = ["nono19@students.desu.edu"]

  spec.summary       = "SpicyValidation generate validation from database schema."
  spec.description   = "SpicyValidation overwrite model file that user would like to generate validation."
  spec.homepage      = "https://github.com/ono-max/spicy_validation"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ono-max/spicy_validation"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
end
