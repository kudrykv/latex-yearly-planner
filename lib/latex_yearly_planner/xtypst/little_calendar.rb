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
            columns: #{number_of_columns},
            align: center,
            inset: #{parameters[:inset]},
            stroke: 0mm,
            #{highlight_week}
            table.cell(colspan: #{number_of_columns})[#{i18n.t("calendar.month.#{month.name.downcase}")}],
            #{weekdays_row.join(', ')},
            #{weeks}
          )
        TYPST
      end

      private

      def number_of_columns
        return 7 unless parameters[:with_week_numbers]

        8
      end

      def highlight_week
        return '' unless parameters[:highlight_week]
        return '' unless parameters[:highlight_day]

        number = parameters[:highlight_day].week.number - month.weeks.first.number + 2

        "fill: (_, y) => if y == #{number} { silver } else { white },"
      end

      def weekdays_row
        row = rotated_weekdays.map { |day| "[#{i18n.t("calendar.one_letter.#{day}")}]" }
        return row unless parameters[:with_week_numbers]

        row.unshift("[#{i18n.t('calendar.one_letter.week')}]") if parameters[:week_number_placement] == 'left'
        row.append("[#{i18n.t('calendar.one_letter.week')}]") if parameters[:week_number_placement] == 'right'

        x = parameters[:week_number_placement] == 'left' ? 1 : 7

        row.unshift("table.vline(x: #{x}, stroke: 0.4pt)") if parameters[:sideline_week_numbers]
        row.unshift('table.hline(y: 2, stroke: 0.4pt)') if parameters[:underline_weekdays]

        row
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
        return "[#{week.number}]" unless parameters[:link_to_week]

        link = "link(<#{week.id}>, [#{week.number}])"

        row.unshift(link) if parameters[:week_number_placement] == 'left'
        row.push(link) if parameters[:week_number_placement] == 'right'

        row.join(', ')
      end

      def map_day(day)
        return '[]' unless day
        return "link(<#{day.id}>, [#{day.day}])" if parameters[:highlight_day] != day

        "table.cell(fill: black, link(<#{day.id}>, text(white)[#{day.day}]))"
      end
    end
  end
end
