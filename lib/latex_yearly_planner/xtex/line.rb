# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Line
      attr_reader :height, :normal_cmd, :colored_cmd

      def initialize(height: '0.4pt', normal_cmd: 'normal', colored_cmd: 'colored')
        @height = height
        @normal_cmd = normal_cmd
        @colored_cmd = colored_cmd
      end

      def register
        <<~TEX
          \\newcommand{\\myLine#{normal_cmd.camelize}}{\\hrule width \\linewidth height #{height}}
          \\newcommand{\\myLine#{colored_cmd.camelize}}[1]{\\textcolor{#1}{\\myLine#{normal_cmd.camelize}}}
        TEX
          .strip
      end
    end
  end
end
