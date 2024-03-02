# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class HSpace
      attr_accessor :width

      def initialize(width)
        @width = width
      end

      def to_s
        "\\hspace{#{width}}"
      end
    end
  end
end
