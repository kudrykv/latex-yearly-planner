# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class VerticalStick
      attr_reader :items, :parameters

      def initialize(items:, **parameters)
        @items = items
        @parameters = RecursiveOpenStruct.new(parameters)
      end

      def to_s
        table = TeX::TabularX.new(**parameters.to_h)
        table.add_rows(transposed)
        table.to_s
      end

      private

      def transposed
        items.each_with_index.map do |item, index|
          row = TeX::TableRow.new([TeX::TableCell.new(item)])
          row.upperline if index == 0
          row.underline

          row
        end
      end
    end
  end
end
