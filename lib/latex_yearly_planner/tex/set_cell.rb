# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class SetCell
      attr_accessor :content, :columns, :rows

      def initialize(content, columns: nil, rows: nil)
        @content = content

        @columns = columns
        @rows = rows
      end

      def to_s
        "{\\SetCell[#{stretch}]{h}#{content}}"
      end

      private

      def stretch
        out = []

        out << "c=#{columns}" if columns
        out << "r=#{rows}" if rows

        out.join(',')
      end
    end
  end
end
