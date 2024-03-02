# frozen_string_literal: true

module LatexYearlyPlanner
  module Entities
    class TextDocument
      attr_reader :name, :content

      def initialize(name:, content:)
        @name = name
        @content = content
      end
    end
  end
end
