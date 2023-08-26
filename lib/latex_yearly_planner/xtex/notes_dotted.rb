# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class NotesDotted
      attr_accessor :width,
                    :height,
                    :horizontal_spacing_between_dots,
                    :vertical_spacing_between_dots,
                    :shift_vertical

      def initialize(**options)
        @width = options.fetch(:width, '1cm')
        @height = options.fetch(:height, '1cm')
        @horizontal_spacing_between_dots = options.fetch(:horizontal_spacing_between_dots, '5mm')
        @vertical_spacing_between_dots = options.fetch(:vertical_spacing_between_dots, '5mm')
        @shift_vertical = options.fetch(:shift_vertical, nil)
      end

      def to_s
        "\\adjustbox{valign=t}{#{minipage}}"
      end

      private

      def minipage
        TeX::Minipage.new(content: raw_notes, width:, height:)
      end

      def raw_notes
        <<~XTX
          #{make_shift_vertical}\\leavevmode\\multido{\\dC=0mm+#{vertical_spacing_between_dots}}{#{make_height}}{
            \\multido{\\dR=0mm+#{horizontal_spacing_between_dots}}{#{make_width}}{
                \\put(\\dR,\\dC){\\circle*{0.1}
              }
            }
          }
        XTX
          .strip.gsub(/\s+/, '')
      end

      def make_height
        (height.to_measurement / vertical_spacing_between_dots.to_measurement).quantity.ceil + 1
      end

      def make_width
        (width.to_measurement / horizontal_spacing_between_dots.to_measurement).quantity.ceil + 1
      end

      def make_shift_vertical
        return '' unless shift_vertical

        "\\vspace{#{shift_vertical}}"
      end
    end
  end
end
