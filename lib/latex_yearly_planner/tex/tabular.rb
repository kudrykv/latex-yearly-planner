# frozen_string_literal: true

module LatexYearlyPlanner
  module TeX
    class Tabular
      attr_accessor :rows,
                    :format,
                    :vertical_stretch,
                    :horizontal_spacing,
                    :horizontal_lines,
                    :min_cell_height

      def initialize(**options)
        @rows = []

        @format = options.fetch(:format, nil)
        @vertical_stretch = options.fetch(:vertical_stretch, 1)
        @horizontal_spacing = options.fetch(:horizontal_spacing, '0pt')
        @horizontal_lines = options.fetch(:horizontal_lines, false)
        @min_cell_height = options.fetch(:min_cell_height, nil)
      end

      def to_s
        <<~LATEX
          {\\renewcommand{\\arraystretch}{#{vertical_stretch}}\\setlength{\\tabcolsep}{#{horizontal_spacing}}%
          \\begin{tabular}{#{make_format}}
            #{starting_hline}
            #{build_rows}#{trailing_hline}
          \\end{tabular}}
        LATEX
          .strip
      end

      def add_row(row)
        rows << row
      end

      def title=(name)
        add_row([TeX::Multicolumn.new(content: name)])
      end

      private

      def make_format
        return format if format

        @rows.map(&:size).max.times.map { 'c' }.join
      end

      def build_rows
        longest_row = rows.map(&:size).max

        rows.map do |row|
          row = row.map do |cell|
            cell.width = longest_row if cell.is_a?(TeX::Multicolumn) && cell.width == :full_width

            "#{make_min_cell_height}#{cell}"
          end

          row.map(&:to_s).join(' & ')
        end.join(separator)
      end

      def separator
        hlines = horizontal_lines ? '\\hline' : ''

        "\\\\#{hlines}\n"
      end

      def starting_hline
        horizontal_lines ? '\\hline' : ''
      end

      def trailing_hline
        horizontal_lines ? '\\\\\\hline' : ''
      end

      def make_min_cell_height
        min_cell_height ? "\\vphantom{\\parbox{0pt}{\\vskip#{min_cell_height}}}" : ''
      end
    end
  end
end
