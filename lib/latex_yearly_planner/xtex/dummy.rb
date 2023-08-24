# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Dummy
      attr_reader :color, :text

      def initialize(color: 'white', text: '.')
        @color = color
        @text = text
      end

      def to_s
        "\\textcolor{#{color}}{#{text}}"
      end
    end
  end
end
