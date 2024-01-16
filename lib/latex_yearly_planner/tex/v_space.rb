# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class VSpace
      attr_reader :height, :with_star

      def initialize(height, with_star: false)
        @height = height
        @with_star = with_star
      end

      def to_s
        "\\vspace#{star}{#{height}}"
      end

      private

      def star
        with_star ? '*' : ''
      end
    end
  end
end
