# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Line
      def self.register
        <<~TEX
          \\newcommand{\\myLineNormal}{\\hrule width \\linewidth height 0.4pt}
          \\newcommand{\\myLineColored}[1]{\\textcolor{#1}{\\myLineNormal}}
        TEX
          .strip
      end

      attr_reader :color

      def initialize(color: nil)
        @color = color
      end

      def to_s
        return '\myLineNormal{}' if color.nil?

        "\\myLineColored{#{color}}"
      end
    end
  end
end
