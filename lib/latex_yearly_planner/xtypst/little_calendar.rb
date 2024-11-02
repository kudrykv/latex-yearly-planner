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
            #{weekdays_row.join(', ')},
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
        return weekdays_row_internal unless parameters[:with_week_numbers]

        apply_week_number_placement!
        apply_sideline_week_numbers!
        apply_underline_weekdays!

        weekdays_row_internal
      end

      def weekdays_row_internal
        @base_weekdays_row ||= rotated_weekdays.map(&method(:one_letter_day))
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

      def apply_underline_weekdays!
        return unless parameters[:underline_weekdays]

        weekdays_row_internal.unshift('table.hline(y: 2, stroke: 0.4pt)')
      end

      def one_letter_day(day)
        "[#{i18n.t("calendar.one_letter.#{day}")}]"
      end

      def one_letter_week
        "[#{i18n.t('calendar.one_letter.week')}]"
      end

      def rotated_weekdays
        WEEKDAYS.rotate(WEEKDAYS.index(month.weekday_start))
      end

      def weeks
        month.weeks.map { |week| week_row(week) }.join(",\n")
      end

      def week_row(week)
        row = week.days.map(&method(:map_day))
        return row.join(', ') unless parameters[:with_week_numbers]

        week_label = "[#{week.number}]"
        week_label = "link(<#{week.id}>, #{week_label})" if parameters[:link_to_week]

        row.unshift(week_label) if parameters[:week_number_placement] == 'left'
        row.push(week_label) if parameters[:week_number_placement] == 'right'

        row.join(', ')
      end

      def map_day(day)
        return '[]' unless day
        return "link(<#{day.id}>, [#{day.day}])" if highlighted_day != day

        "table.cell(fill: black, link(<#{day.id}>, text(white)[#{day.day}]))"
      end

      def highlighted_day
        parameters[:highlight_day]
      end
    end
  end
end
