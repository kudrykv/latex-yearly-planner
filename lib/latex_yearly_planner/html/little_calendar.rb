# frozen_string_literal: true

module LatexYearlyPlanner
  module Html
    class LittleCalendar
      DEFAULT_PARAMETERS = {
        with_week_numbers: true,
        week_number_placement: 'left',
      }.freeze

      WEEKDAYS = %i[monday tuesday wednesday thursday friday saturday sunday].freeze

      attr_reader :i18n, :month, :parameters

      def initialize(month, i18n: I18n, **parameters)
        @i18n = i18n

        @month = month
        @parameters = DEFAULT_PARAMETERS.merge(parameters.compact)
      end

      def to_html
        <<~HTML
          <table class="little-calendar">
            <thead>
              <tr>
                <th colspan="#{number_of_columns}">#{i18n.t("calendar.month.#{month.name.downcase}")}</th>
              </tr>
              <tr>
                #{weekdays_row.map { |day| "<th>#{day}</th>" }.join}
              </tr>
            </thead>
            <tbody>
              #{weeks}
            </tbody>
          </table>
        HTML
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
        month.weeks.map { |week| "<tr>#{week_row(week)}</tr>" }.join
      end

      def week_row(week)
        row = week.days.map { |day| "<td>#{day ? day.day : ''}</td>" }
        return row.join unless parameters[:with_week_numbers]

        row.unshift("<td>#{week.number}</td>") if parameters[:week_number_placement] == 'left'
        row.push("<td>#{week.number}</td>") if parameters[:week_number_placement] == 'right'

        row.join
      end
    end
  end
end
