# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TableRow
      attr_reader :cells
      attr_accessor :underlined, :upperlined

      def initialize(cells)
        @cells = cells
      end

      def size
        cells.size
      end

      def push(cell)
        cells.push(cell)
      end

      def unshift(cell)
        cells.unshift(cell)
      end

      def upperline
        self.upperlined = true

        self
      end

      def underline
        self.underlined = true

        self
      end

      def to_s
        items = [cells.join(' & '), '\\\\']
        items.unshift("\\hline\n") if upperlined
        items << '\hline' if underlined

        items.compact.join
      end
    end
  end
end
