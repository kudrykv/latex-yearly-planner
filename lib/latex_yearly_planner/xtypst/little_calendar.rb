# frozen_string_literal: true

module LatexYearlyPlanner
  module Xtypst
    class LittleCalendar
      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left',
        inset: '1.5mm',
      }.freeze

      WEEKDAYS = %i[monday tuesday wednesday thursday friday saturday sunday].freeze

      attr_reader :i18n, :month, :parameters
      def initialize(month, i18n: I18n, **parameters)
        @i18n = i18n

        @month = month
        @parameters = DEFAULT_PARAMETERS.merge(parameters.compact)
      end

      def to_typst
        <<~TYPST
          table(
            columns: #{number_of_columns},
            align: center,
            inset: #{parameters[:inset]},
            stroke: 0mm,
            table.cell(colspan: #{number_of_columns})[#{i18n.t("calendar.month.#{month.name.downcase}")}],
            #{weekdays_row.map { |day| "[#{day}]" }.join(', ')},
            #{weeks}
          )
        TYPST
      end

      private

      def number_of_columns
        weekdays_row.size
      end

      def weekdays_row
        row = rotated_weekdays.map { |day| i18n.t("calendar.one_letter.#{day}") }
        return row unless parameters[:with_week_numbers]

        row.unshift(i18n.t('calendar.one_letter.week')) if parameters[:week_number_placement] == 'left'
        row.push(i18n.t('calendar.one_letter.week')) if parameters[:week_number_placement] == 'right'

        row
      end

      def rotated_weekdays
        WEEKDAYS.rotate(WEEKDAYS.index(month.weekday_start))
      end

      def weeks
        month.weeks.map { |week| week_row(week) }.join(",\n")
      end

      def week_row(week)
        row = week.days.map { |day| "[#{day ? day.day : ''}]" }
        return row.join(', ') unless parameters[:with_week_numbers]

        row.unshift("[#{week.number}]") if parameters[:week_number_placement] == 'left'
        row.push("[#{week.number}]") if parameters[:week_number_placement] == 'right'

        row.join(', ')
      end
    end
  end
end
