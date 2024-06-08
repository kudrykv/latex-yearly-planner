# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class VerticalStick
      attr_reader :items, :struct

      def initialize(items:, struct:)
        @items = items
        @struct = struct
      end

      def to_s
        table = TeX::TabularX.new(**struct.to_h)
        table.add_vertical_line(struct.vertical_line_after_column)
        table.add_rows(transposed)
        table.to_s
      end

      private

      def transposed
        items.each_with_index.map do |item, index|
          row = TeX::TableRow.new([TeX::TableCell.new(item)])
          row.underline unless index == items.size - 1
          row
        end
      end
    end
  end
end
