# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class NotesLined
      attr_accessor :enabled, :parameters

      def default_parameters
        {
          width: '\\linewidth',
          height: '1cm',
          line_height: '5mm'
        }
      end

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
        "#{MinHeight.new("\\dimexpr#{parameters.line_height}-.4pt")}#{Line.gray}" * number_of_lines
      end

      def number_of_lines
        (height.to_measurement / line_height.to_measurement).quantity.ceil
      end

      def height
        parameters.height
      end

      def line_height
        parameters.line_height
      end
    end
  end
end
