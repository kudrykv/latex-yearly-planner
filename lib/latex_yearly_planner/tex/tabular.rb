# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Tabular
      attr_accessor :rows, :format, :vertical_stretch, :horizontal_spacing, :horizontal_lines

      def initialize(**options)
        @rows = []

        @format = options.fetch(:format, nil)
        @vertical_stretch = options.fetch(:vertical_stretch, 1)
        @horizontal_spacing = options.fetch(:horizontal_spacing, '6pt')
        @horizontal_lines = options.fetch(:horizontal_lines, true)
      end

      def to_s
        <<~LATEX
          {\\renewcommand{\\arraystretch}{#{vertical_stretch}}\\setlength{\\tabcolsep}{#{horizontal_spacing}}%
          \\begin{tabular}{#{make_format}}
            #{build_rows}
          \\end{tabular}}
        LATEX
          .strip
      end

      def add_row(row)
        rows << row
      end

      def title=(name)
        add_row([TeX::Multicolumn.new(content: name)])
      end

      private

      def make_format
        return format if format

        @rows.map(&:size).max.times.map { 'c' }.join
      end

      def build_rows
        longest_row = rows.map(&:size).max

        rows.map do |row|
          row = row.map do |cell|
            cell.width = longest_row if cell.is_a?(TeX::Multicolumn) && cell.width == :full_width

            cell
          end

          row.map(&:to_s).join(' & ')
        end.join(separator)
      end

      def separator
        hlines = horizontal_lines ? '\\hline' : ''

        "\\\\#{hlines}\n"
      end
    end
  end
end
