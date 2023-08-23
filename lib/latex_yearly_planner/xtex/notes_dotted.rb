# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class NotesDotted
      attr_accessor :width, :height

      def initialize(**options)
        @width = options.fetch(:width, 0)
        @height = options.fetch(:height, 0)
      end

      def to_s
        <<~XTX
          \\leavevmode\\multido{\\dC=0mm+5mm}{#{height}}{
            \\multido{\\dR=0mm+5mm}{#{width}}{
                \\put(\\dR,\\dC){\\circle*{0.1}
              }
            }
          }
        XTX
          .strip.gsub(/\s+/, '')
      end
    end
  end
end
