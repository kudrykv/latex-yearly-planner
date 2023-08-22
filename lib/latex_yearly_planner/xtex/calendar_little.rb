# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class CalendarLittle
      attr_reader :month, :width, :show_week_numbers, :week_number_placement, :row_spacing, :column_spacing

      def initialize(month, **options)
        @month = month

        @width = options.fetch(:width, nil)
        @show_week_numbers = options.fetch(:show_week_numbers, true)
        @week_number_placement = options.fetch(:week_number_placement, :right).downcase.to_sym
        @row_spacing = options.fetch(:row_spacing, nil)
        @column_spacing = options.fetch(:column_spacing, nil)
      end

      def to_s
        table = TeX::Tblr.new

        table.title = month.name
        table.width = width
        table.format = format
        table.row_spacing = row_spacing
        table.column_spacing = column_spacing

        table.add_row(header)
        week_rows.each { |row| table.add_row(row) }

        table.to_s
      end

      private

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
