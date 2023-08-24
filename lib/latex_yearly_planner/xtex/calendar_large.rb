# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class CalendarLarge
      attr_reader :month, :show_week_numbers, :week_number_placement

      def initialize(month, **options)
        @month = month

        @show_week_numbers = options.fetch(:show_week_numbers, true)
        @week_number_placement = options.fetch(:week_number_placement, :left)
      end

      def to_s
        table = TeX::Tblr.new(**table_options)

        table.add_row(header)

        week_rows.each { |row| table.add_row(row) }

        table
      end

      private

      def table_options
        { format:, horizontal_lines: true }
      end

      def format
        return "#{'|X' * 7}|" unless show_week_numbers

        return "|c|#{'X|' * 7}" if week_number_placement == :left

        "#{'|X' * 7}|c|"
      end

      def header
        row = month.weekdays_short.map { |day| "\\hfil{}#{day}" }

        return row unless show_week_numbers

        return ['W'] + row if week_number_placement == :left

        row + ['W']
      end

      def week_rows
        month.weeks.map do |week|
          row = week.days.map { |day| day ? "{#{day.mday}}" : '' }
          next row unless show_week_numbers

          wn = "\\rotatebox{90}{\\parbox{2cm}{Week #{week.number}}}"
          row.unshift(wn) if week_number_placement == :left
          row.push(wn) if week_number_placement == :right

          row
        end
      end
    end
  end
end
