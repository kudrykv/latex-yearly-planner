# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Tblr
      attr_accessor :rows, :format, :row_spacing, :column_spacing, :horizontal_lines, :width

      def initialize(vertical_padding_factor: 1, column_spacing: '1pt', row_spacing: '6pt', width: '\\linewidth')
        @rows = []

        @vertical_padding_factor = vertical_padding_factor
        @column_spacing = column_spacing
        @row_spacing = row_spacing
        @width = width
      end

      def add_row(row)
        rows << row
      end

      def title=(name)
        add_row([TeX::SetCell.new(name, columns: :full_width)])
      end

      def to_s
        <<~LATEX
          \\begin{tblr}{
            width = #{width},
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
        longest_row = rows.map(&:size).max

        rows.map do |row|
          row = row.map do |cell|
            cell.columns = longest_row if cell.is_a?(TeX::SetCell) && cell.columns == :full_width

            cell
          end

          row.map(&:to_s).join(' & ')
        end.join("\\\\\n")
      end
    end
  end
end
