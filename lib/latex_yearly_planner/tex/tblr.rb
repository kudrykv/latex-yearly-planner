# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Tblr
      attr_accessor :rows, :format, :row_spacing, :column_spacing, :horizontal_lines, :width

      def initialize(vertical_padding_factor: 1, column_spacing: nil, row_spacing: nil, width: nil)
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
          \\begin{tblr}[T]{#{table_options}}
            #{build_rows}
          \\end{tblr}
        LATEX
          .strip
      end

      private

      def table_options
        [
          make_width,
          make_row_spacing,
          make_column_spacing,
          make_format
        ].compact.join(', ')
      end

      def make_width
        "width = #{width}" if width
      end

      def make_row_spacing
        "rowsep = #{row_spacing}" if row_spacing
      end

      def make_column_spacing
        "colsep = #{column_spacing}" if column_spacing
      end

      def make_format
        return "colspec = {#{format}}" if format

        line = @rows.map(&:size).max.times.map { 'c' }.join('|')

        "colspec = {#{line}}"
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
