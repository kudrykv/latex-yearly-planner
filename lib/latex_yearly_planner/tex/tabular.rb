# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Tabular
      attr_accessor :rows

      def initialize
        @rows = []
      end

      def add_row(row)
        rows << row
      end

      def to_s
        <<~LATEX
          \\begin{tabular}{#{format}}
            #{build_rows}
          \\end{tabular}
        LATEX
          .strip
      end

      private

      def format
        @rows.map(&:size).max.times.map { 'c' }.join('|')
      end

      def build_rows
        rows.map { |row| "#{row.join(' & ')} \\\\" }.join("\n")
      end
    end
  end
end
