# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class LittleCalendar
      include Handy

      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left'
      }.freeze

      attr_reader :month, :parameters

      def initialize(month:, **parameters)
        @month = month
        @parameters = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(parameters.compact))
      end

      def to_s
        adjust_box(table_month)
      end

      private

      def table_month
        table = TeX::TabularX.new
        table.rows = month.weeks.map(&method(:week_row))

        table
      end

      def week_row(week)
        week.days.map { |day| day ? TeX::TableCell.new(day.day) : '' }
      end
    end
  end
end
