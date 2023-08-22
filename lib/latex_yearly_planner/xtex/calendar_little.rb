# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class CalendarLittle
      def initialize(month, width: '\\linewidth', show_week_numbers: true, week_number_placement: :left)
        @month = month
        @width = width
        @show_week_numbers = show_week_numbers
        @week_number_placement = week_number_placement.downcase.to_sym
      end

      def to_s
        table = TeX::Tblr.new

        table.title = month.name
        table.width = width
        table.format = format
        table.add_row(header)

        week_rows.each { |row| table.add_row(row) }

        table.to_s
      end

      private

      attr_reader :month, :width, :show_week_numbers, :week_number_placement

      def header
        row = month.weekdays_one_letter

        return row unless show_week_numbers

        return ['W'] + row if week_number_placement == :left

        row + ['W']
      end

      def format
        return 'X[c]' * 7 unless show_week_numbers

        return "X[c]|#{'X[c]' * 7}" if week_number_placement == :left

        "#{'X[c]' * 7}|X[c]"
      end

      def week_rows
        month.weeks.map do |week|
          row = week.days.map { |day| day ? "{#{day.mday}}" : '' }
          next row unless show_week_numbers

          row.unshift(week.number) if week_number_placement == :left
          row.push(week.number) if week_number_placement == :right

          row
        end
      end
    end
  end
end
