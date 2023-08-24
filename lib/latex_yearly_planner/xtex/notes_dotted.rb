# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class NotesDotted
      attr_accessor :width, :height, :shift_vertical

      def initialize(**options)
        @width = options.fetch(:width, '1cm')
        @height = options.fetch(:height, '1cm')
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
          #{make_shift_vertical}\\leavevmode\\multido{\\dC=0mm+5mm}{#{make_height}}{
            \\multido{\\dR=0mm+5mm}{#{make_width}}{
                \\put(\\dR,\\dC){\\circle*{0.1}
              }
            }
          }
        XTX
          .strip.gsub(/\s+/, '')
      end

      def make_height
        (height.to_measurement / '5 mm'.to_measurement).quantity.ceil + 1
      end

      def make_width
        (width.to_measurement / '5 mm'.to_measurement).quantity.ceil
      end

      def make_shift_vertical
        return '' unless shift_vertical

        "\\vspace{#{shift_vertical}}"
      end
    end
  end
end
