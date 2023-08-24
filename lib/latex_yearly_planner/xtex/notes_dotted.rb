# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class NotesDotted
      attr_accessor :width, :height, :compensate_height

      def initialize(**options)
        @width = options.fetch(:width, '1cm')
        @height = options.fetch(:height, '1cm')
        @compensate_height = options.fetch(:compensate_height, nil)
      end

      def to_s
        TeX::Minipage.new(
          content: raw_notes,
          width:,
          height:,
          compensate_height:,
        ).to_s
      end

      private

      def raw_notes
        <<~XTX
          \\leavevmode\\multido{\\dC=0mm+5mm}{#{make_height}}{
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
    end
  end
end
