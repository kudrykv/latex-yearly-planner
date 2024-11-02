# frozen_string_literal: true

module LatexYearlyPlanner
  module Xtypst
    class LittleCalendar
      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left',
        inset: '1.5mm',
        underline_weekdays: true,
        sideline_week_numbers: true,
        highlight_week: false,
        link_to_week: true,
        take_full_width: true,

        highlight_day: nil
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
            columns: #{columns},
            align: center,
            inset: #{parameters[:inset]},
            stroke: 0mm,
            #{highlight_week}
            table.cell(colspan: #{number_of_columns})[#{month_name}],
            #{weekdays_row},
            #{weeks}
          )
        TYPST
      end

      private

      def columns
        return number_of_columns unless parameters[:take_full_width]

        "(#{(['1fr'] * number_of_columns).join(', ')})"
      end

      def number_of_columns
        return 7 unless parameters[:with_week_numbers]

        8
      end

      def highlight_week
        return '' unless parameters[:highlight_week]
        return '' unless highlighted_day

        "fill: (_, y) => if y == #{highlighted_week_number_in_this_month} { silver } else { white },"
      end

      def highlighted_week_number_in_this_month
        highlighted_day.week.number - month.weeks.first.number + 2
      end

      def month_name
        i18n.t("calendar.month.#{month.name.downcase}")
      end

      def weekdays_row
        LittleWeekdaysRow.new(weekday_start: month.weekday_start, i18n:, **parameters).to_typst
      end

      def weeks
        month.weeks
             .map { |week| LittleCalendarRow.new(week, **parameters).to_typst }
             .join(",\n")
      end

      def highlighted_day
        parameters[:highlight_day]
      end
    end
  end
end
