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
        week_cell_rotate: '90deg',
        link_to_week: true
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
        return rotated_weekdays unless parameters[:with_week_numbers]

        one_letter_week = "[#{i18n.t('calendar.one_letter.week')}]"
        rotated_weekdays.unshift(one_letter_week) if parameters[:week_number_placement] == 'left'
        rotated_weekdays.append(one_letter_week) if parameters[:week_number_placement] == 'right'

        rotated_weekdays.map { |i| "align(center + horizon, #{i})" }
      end

      def rotated_weekdays
        @rotated_weekdays ||= WEEKDAYS
                              .rotate(WEEKDAYS.index(month.weekday_start))
                              .map do |day|
                                "[#{i18n.t("calendar.weekdays.#{parameters[:weekday_names]}.#{day}")}]"
                              end
      end

      def weeks
        month.weeks.map(&method(:week_row)).join(",\n")
      end

      def week_row(week)
        row = week.days.map(&method(:linkify_day))
        return row.join(', ') unless parameters[:with_week_numbers]

        row.unshift(rotate_week(week)) if parameters[:week_number_placement] == 'left'
        row.push(rotate_week(week)) if parameters[:week_number_placement] == 'right'

        row.join(', ')
      end

      def linkify_day(day)
        return '[]' unless day

        "link(<#{day.id}>, [#{day.day}])"
      end

      def rotate_week(week)
        label = "#{i18n.t('calendar.weekdays.full.week')} #{week.number}"
        label = "#link(<#{week.id}>, [#{label}])" if parameters[:link_to_week]

        <<~TYPST
          rotate(
            #{parameters[:week_cell_rotate]},
            origin: center + horizon,
            reflow: true,
            [#h(1fr) #{label} #h(1fr)]
          )
        TYPST
      end
    end
  end
end
