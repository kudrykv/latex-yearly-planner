# frozen_string_literal: true

module LatexYearlyPlanner
  module Xtypst
    class LittleWeekdaysRow
      WEEKDAYS = %i[monday tuesday wednesday thursday friday saturday sunday].freeze
      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        underline_weekdays: true,
        sideline_week_numbers: true,
        week_number_placement: 'right',
      }.freeze

      attr_reader :weekday_start, :i18n, :parameters

      def initialize(weekday_start:, i18n: I18n, **parameters)
        @i18n = i18n
        @parameters = DEFAULT_PARAMETERS.merge(parameters.compact)

        @weekday_start = weekday_start
      end

      def to_typst
        weekdays_row.join(', ')
      end

      private

      def weekdays_row
        apply_underline_weekdays!
        return weekdays_row_internal unless parameters[:with_week_numbers]

        apply_week_number_placement!
        apply_sideline_week_numbers!

        weekdays_row_internal
      end

      def apply_underline_weekdays!
        return unless parameters[:underline_weekdays]

        weekdays_row_internal.unshift('table.hline(y: 2, stroke: 0.4pt)')
      end

      def apply_week_number_placement!
        return weekdays_row_internal.unshift(one_letter_week) if parameters[:week_number_placement] == 'left'

        weekdays_row_internal.append(one_letter_week)
      end

      def apply_sideline_week_numbers!
        return unless parameters[:sideline_week_numbers]

        x = parameters[:week_number_placement] == 'left' ? 1 : 7
        weekdays_row_internal.unshift("table.vline(x: #{x}, stroke: 0.4pt)")
      end


      def weekdays_row_internal
        @weekdays_row_internal ||= rotated_weekdays.map(&method(:one_letter_day))
      end

      def rotated_weekdays
        WEEKDAYS.rotate(WEEKDAYS.index(weekday_start))
      end

      def one_letter_day(day)
        "[#{i18n.t("calendar.one_letter.#{day}")}]"
      end

      def one_letter_week
        "[#{i18n.t('calendar.one_letter.week')}]"
      end
    end
  end
end
