# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TabularX
      attr_accessor :width, :rows, :format
      attr_reader :position

      def initialize(position: 'c')
        @rows = []

        @position = position
      end

      def title=(name)
        add_row([Multicolumn.new(:full_width, :c, name)])
      end

      def add_row(row)
        rows << row
      end

      def to_s
        <<~LATEX
          {\\renewcommand{\\arraystretch}{1}\\setlength{\\tabcolsep}{0mm}%
          \\begin{tabularx}{#{width}}[#{position}]{#{format}}
          #{build_rows}
          \\end{tabularx}}
        LATEX
          .strip
      end

      private

      def build_rows
        longest_row = rows.map(&:size).max

        rows.map do |row|
          row = row.map do |cell|
            cell.width = longest_row if cell.is_a?(Multicolumn) && cell.width == :full_width

            cell
          end

          row.map(&:to_s).join(' & ')
        end.join("\\\\\n")
      end
    end

    class Multicolumn
      attr_accessor :width, :format, :content

      def initialize(width, format, content)
        @width = width
        @format = format
        @content = content
      end

      def to_s
        "\\multicolumn{#{width}}{#{format}}{#{content}}"
      end
    end
  end
end
