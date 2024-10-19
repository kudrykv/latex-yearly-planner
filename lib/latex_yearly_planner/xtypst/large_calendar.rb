# frozen_string_literal: true

module LatexYearlyPlanner
  module Xtypst
    class LargeCalendar
      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left',
        weekday_names: 'full',
        heading_height: '6mm',
        week_row_height: '1cm',
        week_cell_rotate: '90deg'
      }.freeze

      WEEKDAYS = %i[monday tuesday wednesday thursday friday saturday sunday].freeze

      attr_reader :i18n, :month, :parameters

      def initialize(month, i18n: I18n, **parameters)
        @month = month
        @i18n = i18n
        @parameters = DEFAULT_PARAMETERS.merge(parameters.compact)
      end

      def to_typst
        <<~TYPST
          table(
            stroke: 0.4pt,
            columns: (#{columns}),
            rows: (#{parameters[:heading_height]}, #{([parameters[:week_row_height]] * (month.weeks.size - 1)).join(', ')}),
            align: top + left,
            #{weekdays_row.join(', ')},
            #{weeks}
          )
        TYPST
      end

      private

      def columns
        cols = ['1fr'] * 7

        cols.append('auto') if parameters[:with_week_numbers] && parameters[:week_number_placement] == 'right'
        cols.prepend('auto') if parameters[:with_week_numbers] && parameters[:week_number_placement] == 'left'

        cols.join(', ')
      end

      def number_of_columns
        return 7 unless parameters[:with_week_numbers]

        8
      end

      def weekdays_row
        row = rotated_weekdays.map { |day| "[#{i18n.t("calendar.weekdays.#{parameters[:weekday_names]}.#{day}")}]" }
        return row unless parameters[:with_week_numbers]

        row.unshift("[#{i18n.t('calendar.one_letter.week')}]") if parameters[:week_number_placement] == 'left'
        row.append("[#{i18n.t('calendar.one_letter.week')}]") if parameters[:week_number_placement] == 'right'

        x = parameters[:week_number_placement] == 'left' ? 1 : 7

        row.unshift("table.vline(x: #{x}, stroke: 0.4pt)") if parameters[:sideline_week_numbers]
        row.unshift('table.hline(y: 2, stroke: 0.4pt)') if parameters[:underline_weekdays]

        row.map { |i| "align(center + horizon, #{i})" }
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

        row.unshift(rotate_week(week)) if parameters[:week_number_placement] == 'left'
        row.push(rotate_week(week)) if parameters[:week_number_placement] == 'right'

        row.join(', ')
      end

      def rotate_week(week)
        <<~TYPST
          rotate(
            #{parameters[:week_cell_rotate]},
            origin: center + horizon,
            reflow: true,
            [#h(1fr) #link(label("#{week.id}"), [#{i18n.t('calendar.weekdays.full.week')} #{week.number}]) #h(1fr)]
          )
        TYPST
      end
    end
  end
end
