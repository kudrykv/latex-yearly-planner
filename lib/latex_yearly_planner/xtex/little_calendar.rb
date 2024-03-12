# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class LittleCalendar
      include Handy

      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left'
      }.freeze

      WEEKDAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

      attr_reader :i18n, :month, :parameters

      def initialize(month:, i18n: I18n, **parameters)
        @i18n = i18n
        @month = month
        @parameters = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(parameters.compact))
      end

      def to_s
        adjust_box(table_month)
      end

      private

      def table_month
        table = TeX::TabularX.new(**parameters.to_h)
        table.add_rows(month.weeks.map(&method(:week_row)))

        table
      end

      def week_row(week)
        TeX::TableRow.new(week.days.map { |day| day ? TeX::TableCell.new(day.day) : '' })
      end
    end
  end
end
