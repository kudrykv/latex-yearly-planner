# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class IndexTable
      def default_parameters
        {
          horizontal_lines: true,
          format: 'rX',
          start_from: 1,
          count: 1,
          line_height: '5mm'
        }
      end

      attr_accessor :enabled, :parameters

      def initialize(**options)
        @enabled = options.fetch(:enabled, true)
        @parameters = RecursiveOpenStruct.new(default_parameters.deep_merge(options.fetch(:parameters, {}).compact))
      end

      def to_s
        return '' unless enabled

        index_table.to_s
      end

      private

      def index_table
        table = TeX::TabularX.new(**parameters.to_h)

        parameters.start_from.upto(parameters.start_from + parameters.count - 1) do |i|
          table.add_row(["#{MinHeight.new(parameters.line_height)}#{i}.", ''])
        end

        table
      end
    end
  end
end
