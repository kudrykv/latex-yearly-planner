# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class MinHeight
      attr_accessor :height

      def initialize(height)
        @height = height
      end

      def to_s
        "\\vphantom{\\parbox{0pt}{\\vskip#{height}}}"
      end
    end
  end
end
