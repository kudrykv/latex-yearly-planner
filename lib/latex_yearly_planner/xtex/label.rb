# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Label
      def default_parameters
        {
          text: '',
          line_height: '5mm',
          vertical_shift: nil
        }
      end

      attr_accessor :enabled, :parameters

      def initialize(**options)
        @enabled = options.fetch(:enabled, false)
        @parameters = RecursiveOpenStruct.new(default_parameters.deep_merge(options.fetch(:parameters, {}).compact))
      end

      def to_s
        return '' unless enabled

        [vertical_shift, line_height, parameters.text, Line.plain].join
      end

      private

      def vertical_shift
        return '' unless parameters.vertical_shift

        "\\vspace{#{parameters.vertical_shift}}"
      end

      def line_height
        return '' unless parameters.line_height

        MinHeight.new(parameters.line_height)
      end
    end
  end
end
