# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Label
      def default_parameters
        {
          text: '',
          line_height: '5mm',
          width: nil,
          shift_vertical: nil
        }
      end

      attr_accessor :enabled, :parameters

      def initialize(**options)
        @enabled = options.fetch(:enabled, false)
        @parameters = RecursiveOpenStruct.new(default_parameters.deep_merge(options.fetch(:parameters, {}).compact))
      end

      def to_s
        return '' unless enabled
        return line unless parameters.width

        TeX::Parbox.new(content: line, width: parameters.width).to_s
      end

      private

      def line
        [shift_vertical, line_height, parameters.text, Line.plain].join
      end

      def shift_vertical
        return '' unless parameters.shift_vertical

        "\\vspace{#{parameters.shift_vertical}}"
      end

      def line_height
        return '' unless parameters.line_height

        MinHeight.new(parameters.line_height)
      end
    end
  end
end
