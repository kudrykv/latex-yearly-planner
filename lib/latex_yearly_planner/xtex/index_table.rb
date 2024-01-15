# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class IndexTable
      include HyperHelpers

      def default_parameters
        {
          horizontal_lines: true,
          format: 'rX',
          start_from: 1,
          count: 1,
          line_height: '5mm',
          make_ref: ->(_index) { '' }
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

        from_to_entries.each do |index|
          num = "#{MinHeight.new(parameters.line_height)}#{index}."
          reference = parameters.make_ref.call(index)

          table.add_row([link_reference(num, reference:), ''])
        end

        table
      end

      def from_to_entries
        parameters.start_from.upto(parameters.start_from + parameters.count - 1)
      end
    end
  end
end
