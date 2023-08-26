# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class NotesDotted
      def default_parameters
        {
          width: '1cm',
          height: '1cm',
          horizontal_spacing_between_dots: '5mm',
          vertical_spacing_between_dots: '5mm',
          shift_vertical: nil
        }
      end

      attr_accessor :enabled, :parameters

      def initialize(**options)
        @enabled = options.fetch(:enabled, true)
        @parameters = RecursiveOpenStruct.new(default_parameters.deep_merge(options.fetch(:parameters, {}).compact))
      end

      def to_s
        return '' unless enabled

        "\\adjustbox{valign=t}{#{minipage}}"
      end

      private

      def minipage
        TeX::Minipage.new(content:, width: parameters.width, height: parameters.height)
      end

      def content
        <<~XTX
          #{shift_vertical}\\leavevmode\\multido{\\dC=0mm+#{vertical_spacing_between_dots}}{#{height_in_dots_number}}{
            \\multido{\\dR=0mm+#{horizontal_spacing_between_dots}}{#{width_in_dots_number}}{
                \\put(\\dR,\\dC){\\circle*{0.1}
              }
            }
          }
        XTX
          .strip.gsub(/\s+/, '')
      end

      def shift_vertical
        return '' unless parameters.shift_vertical

        "\\vspace{#{parameters.shift_vertical}}"
      end

      def vertical_spacing_between_dots
        parameters.vertical_spacing_between_dots
      end

      def height_in_dots_number
        (height.to_measurement / vertical_spacing_between_dots.to_measurement).quantity.ceil + 1
      end

      def horizontal_spacing_between_dots
        parameters.horizontal_spacing_between_dots
      end

      def width_in_dots_number
        (width.to_measurement / horizontal_spacing_between_dots.to_measurement).quantity.ceil
      end

      def width
        parameters.width
      end

      def height
        parameters.height
      end
    end
  end
end
