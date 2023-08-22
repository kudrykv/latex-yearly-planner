# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Tblr
      attr_accessor :rows, :format, :row_spacing, :column_spacing, :horizontal_lines

      def initialize(vertical_padding_factor: 1, column_spacing: '1pt', row_spacing: '6pt')
        @rows = []

        @vertical_padding_factor = vertical_padding_factor
        @column_spacing = column_spacing
        @row_spacing = row_spacing
      end

      def add_row(row)
        rows << row
      end

      def to_s
        <<~LATEX
          \\begin{tblr}{
            colspec = {#{make_format}},
            rowsep = #{row_spacing},
            colsep = #{column_spacing}
          }
            #{build_rows}
          \\end{tblr}
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
