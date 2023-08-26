# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Label
      def default_parameters
        {
          text: '',
          line_height: '5mm'
        }
      end

      attr_accessor :enabled, :parameters

      def initialize(**options)
        @enabled = options.fetch(:enabled, false)
        @parameters = OpenStruct.new(default_parameters.merge(options.fetch(:parameters, {}).compact))
      end

      def to_s
        return '' unless enabled

        "#{MinHeight.new(parameters.line_height)}#{parameters.text}#{Line.plain}"
      end
    end
  end
end
