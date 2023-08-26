# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class VSpace
      attr_reader :height

      def initialize(height)
        @height = height
      end

      def to_s
        "\\vspace{#{height}}"
      end
    end

  end
end
