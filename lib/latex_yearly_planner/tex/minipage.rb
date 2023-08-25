# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Minipage
      attr_accessor :content, :width, :height, :position, :inner_position, :compensate_height

      def initialize(**options)
        @content = options.fetch(:content, '')
        @width = options.fetch(:width, '\\linewidth')
        @height = options.fetch(:height, nil)
        @position = options.fetch(:position, 't')
        @inner_position = options.fetch(:inner_position, nil)
        @compensate_height = options.fetch(:compensate_height, nil)
      end

      def to_s
        <<~LATEX
          \\begin{minipage}#{make_options}{#{width}}#{compensate}#{content}\\end{minipage}
        LATEX
          .strip
      end

      private

      def make_options
        options = [position, make_height, inner_position].compact
        return '' if options.empty?

        "[#{options.join('][')}]"
      end

      def make_height
        return nil if height.nil?
        return height unless compensate_height

        "\\dimexpr#{height} - #{compensate_height}"
      end

      def compensate
        return '' unless compensate_height

        "\\vspace{-#{compensate_height}}"
      end
    end
  end
end
