# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TabularX
      DEFAULT_PARAMETERS = {
        width: '\\textwidth',
        vertical_stretch: 1,
        horizontal_spacing: '0pt',
      }.freeze

      attr_accessor :rows, :parameters

      def initialize(**parameters)
        @parameters = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(parameters.compact))
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
        rows.first.size.times.map { 'Y' }.join
      end

      def build_rows
        rows.map { |row| "#{row.join(' & ')} \\\\" }.join("\n")
      end
    end
  end
end
