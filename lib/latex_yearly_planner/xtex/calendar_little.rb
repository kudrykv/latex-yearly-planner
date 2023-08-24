# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class CalendarLittle
      attr_reader :month,
                  :width,
                  :show_week_numbers,
                  :week_number_placement,
                  :vertical_stretch,
                  :horizontal_spacing

      def initialize(month, **options)
        @month = month

        @width = options.fetch(:width, nil)
        @show_week_numbers = options.fetch(:show_week_numbers, true)
        @week_number_placement = options.fetch(:week_number_placement, :right).downcase.to_sym
        @vertical_stretch = options.fetch(:vertical_stretch, 1)
        @horizontal_spacing = options.fetch(:horizontal_spacing, '6pt')
      end

      def to_s
        table = TeX::TabularX.new(**table_options)

        table.title = month.name
        table.add_row(header)

        week_rows.each { |row| table.add_row(row) }

        "\\adjustbox{valign=t}{#{table.to_s}}"
      end

      private

      def table_options
        { width:, format:, vertical_stretch:, horizontal_spacing: }
      end

      def header
        row = month.weekdays_one_letter

        return row unless show_week_numbers

        return ['W'] + row if week_number_placement == :left

        row + ['W']
      end

      def format
        return 'Y' * 7 unless show_week_numbers

        return "Y|#{'Y' * 7}" if week_number_placement == :left

        "#{'Y' * 7}|Y"
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
