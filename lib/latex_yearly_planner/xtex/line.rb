# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Line
      attr_reader :height, :normal_cmd, :colored_cmd

      def self.register
        <<~TEX
          \\newcommand{\\myLineNormal}{\\hrule width \\linewidth height 0.4pt}
          \\newcommand{\\myLineColored}[1]{\\textcolor{#1}{\\myLineNormal}}
        TEX
          .strip
      end
    end
  end
end
