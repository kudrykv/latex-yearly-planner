# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Minipage
      attr_accessor :content, :width, :height, :position, :inner_position

      def initialize(**options)
        @content = options.fetch(:content, '')
        @width = options.fetch(:width, '\\textwidth')
        @height = options.fetch(:height, nil)
        @position = options.fetch(:position, 't')
        @inner_position = options.fetch(:inner_position, nil)
      end

      def to_s
        <<~LATEX
          \\begin{minipage}#{make_options}{#{width}}#{content}\\end{minipage}
        LATEX
          .strip
      end

      private

      def make_options
        options = [position, height, inner_position].compact
        return '' if options.empty?

        "[#{options.join('][')}]"
      end
    end
  end
end
