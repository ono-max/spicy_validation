# frozen_string_literal: true

module NewHashSyntax
  refine Hash do
    def format_hash
      map { |k, v| "#{k}: #{v.inspect}" }.join(", ")
    end
  end
end
