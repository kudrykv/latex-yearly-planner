# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TabularX
      DEFAULT_PARAMETERS = {
        width: '\\linewidth',
        vertical_stretch: 1,
        horizontal_spacing: '0pt'
      }.freeze

      attr_accessor :vertical_line_indexes, :rows, :parameters, :formatting

      def initialize(**parameters)
        self.parameters = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(parameters.compact))
        self.rows = parameters[:rows] || []
        self.vertical_line_indexes = []
        self.formatting = parameters[:formatting]
      end

      def add_rows(rows)
        self.rows.concat(rows)
      end

      def add_row(row)
        rows << row
      end

      def add_vertical_line(index)
        @vertical_line_indexes << index
      end

      def to_s
        <<~LATEX
          {\\renewcommand{\\arraystretch}{#{parameters.vertical_stretch}}%
          \\setlength{\\tabcolsep}{#{parameters.horizontal_spacing}}%
          \\begin{tabularx}{#{parameters.width}}{#{make_format}}
            #{build_rows}
          \\end{tabularx}}
        LATEX
          .strip
      end

      private

      def make_format
        return formatting if formatting

        format = rows.map(&:size).max.times.map { 'Y' }.join

        vertical_line_indexes.sort.reverse.each do |index|
          format.insert(index, '|')
        end

        format
      end

      def build_rows
        rows.map(&:to_s).join("\n  ") # two spaces for indentation
      end
    end
  end
end
