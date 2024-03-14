# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class LittleCalendar
      include Handy

      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left',
        underline_weekdays: false,
        upperline_weekdays: false
      }.freeze

      WEEKDAYS = %i[monday tuesday wednesday thursday friday saturday sunday].freeze

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
        table.add_row(month_name_row)
        table.add_row(column_headings)
        table.add_rows(weeks)

        table
      end

      def month_name_row
        TeX::TableRow.new([TeX::TableMulticolumn.new(i18n.t("calendar.month.#{month.name.downcase}"), columns_number)])
      end

      def columns_number
        return 7 unless parameters.with_week_numbers

        8
      end

      def weeks
        month.weeks.map(&method(:week_row))
      end

      def week_row(week)
        row = TeX::TableRow.new(week.days.map { |day| TeX::TableCell.new(day ? day.day : '') })
        return row unless parameters.with_week_numbers

        add_week_number(row, week)
      end

      def add_week_number(row, week)
        week_num = TeX::TableCell.new(week.number)
        row.unshift(week_num) if parameters.week_number_placement == 'left'
        row.push(week_num) if parameters.week_number_placement == 'right'

        row
      end

      def column_headings
        row = weekdays_row
        return row unless parameters.with_week_numbers

        week_cell = TeX::TableCell.new(i18n.t('calendar.one_letter.week'))
        row.unshift(week_cell) if parameters.week_number_placement == 'left'
        row.push(week_cell) if parameters.week_number_placement == 'right'

        row
      end

      def weekdays_row
        cells = rotated_weekdays.map { |day| TeX::TableCell.new(i18n.t("calendar.one_letter.#{day}")) }

        row = TeX::TableRow.new(cells)

        row.underline if parameters.underline_weekdays
        row.upperline if parameters.upperline_weekdays

        row
      end

      def rotated_weekdays
        WEEKDAYS.rotate(WEEKDAYS.index(month.weekday_start))
      end
    end
  end
end
