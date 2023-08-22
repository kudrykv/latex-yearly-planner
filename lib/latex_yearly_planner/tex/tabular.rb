# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Tabular
      attr_accessor :rows, :vertical_padding_factor, :format, :horizontal_lines, :column_spacing

      def initialize(vertical_padding_factor: 1, column_spacing: '1pt')
        @rows = []

        @vertical_padding_factor = vertical_padding_factor
        @column_spacing = column_spacing
      end

      def add_row(row)
        rows << row
      end

      def to_s
        <<~LATEX
          {\\renewcommand{\\arraystretch}{#{vertical_padding_factor}}\\setlength{\\tabcolsep}{#{column_spacing}}%
          \\begin{tabular}{#{make_format}}
            #{build_rows}
          \\end{tabular}}
        LATEX
          .strip
      end

      private

      def make_format
        return format if format

        @rows.map(&:size).max.times.map { 'c' }.join('|')
      end

      def build_rows
        out = "#{horizontal_line}\n"

        out += rows.map { |row| "#{row.join(' & ')} \\\\#{horizontal_line}" }.join("\n")

        out.strip
      end

      def horizontal_line
        horizontal_lines ? '\\hline' : ''
      end
    end
  end
end
