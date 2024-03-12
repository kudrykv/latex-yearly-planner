# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TableRow
      attr_reader :cells

      def initialize(cells)
        @cells = cells
      end

      def size
        cells.size
      end

      def to_s
        "#{cells.join(' & ')} \\\\"
      end
    end
  end
end
