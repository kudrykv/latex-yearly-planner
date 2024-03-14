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
        table.add_rows(weeks)

        table
      end

      def weeks
        month.weeks.map(&method(:week_row))
      end

      def week_row(week)
        row = TeX::TableRow.new(week.days.map { |day| TeX::TableCell.new(day ? day.day : '') })
        return row unless parameters.with_week_numbers

        week_num = TeX::TableCell.new(week.number)
        row.unshift(week_num) if parameters.week_number_placement == 'left'
        row.push(week_num) if parameters.week_number_placement == 'right'

        row
      end
    end
  end
end
