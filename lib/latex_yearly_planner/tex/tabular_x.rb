# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class TabularX
      DEFAULT_PARAMETERS = {
        width: '\\textwidth',
        vertical_stretch: 1,
        horizontal_spacing: '0pt',
      }.freeze

      attr_accessor :rows, :width, :vertical_stretch, :horizontal_spacing

      def initialize
        @width = DEFAULT_PARAMETERS[:width]
        @vertical_stretch = DEFAULT_PARAMETERS[:vertical_stretch]
        @horizontal_spacing = DEFAULT_PARAMETERS[:horizontal_spacing]
      end

      def to_s
        <<~LATEX
          \\renewcommand{\\arraystretch}{#{vertical_stretch}}%
          \\setlength{\\tabcolsep}{#{horizontal_spacing}}%
          \\begin{tabularx}{#{width}}{#{make_format}}
            #{build_rows}
          \\end{tabularx}
        LATEX
          .strip
      end

      private

      def make_format
        rows.first.size.times.map { 'X' }.join(' ')
      end

      def build_rows
        rows.map { |row| "#{row.join(' & ')} \\\\" }.join("\n")
      end
    end
  end
end
