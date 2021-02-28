# frozen_string_literal: true

module NewHashSyntax
  refine Hash do
    def to_s
      map { |k, v| "#{k}: #{v.inspect}" }.join(", ")
    end
  end
end
