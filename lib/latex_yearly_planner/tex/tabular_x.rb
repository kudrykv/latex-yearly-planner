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
          \\begin{tabularx}{#{width}}{|X|}
            hello
          \\end{tabularx}
        LATEX
          .strip
      end
    end
  end
end
