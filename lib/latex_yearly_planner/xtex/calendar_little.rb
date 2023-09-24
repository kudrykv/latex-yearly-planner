# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class CalendarLittle
      include HyperHelpers

      def default_parameters
        {
          width: nil,
          show_week_numbers: true,
          week_number_placement: :right,
          vertical_stretch: 1,
          horizontal_spacing: '6pt',
          highlight_day: nil
        }
      end

      attr_reader :month, :enabled, :parameters

      def initialize(month, **options)
        @month = month

        @enabled = options.fetch(:enabled, true)
        @parameters = RecursiveOpenStruct.new(default_parameters.deep_merge(options.fetch(:parameters, {}).compact))
      end

      def to_s
        return '' unless enabled

        table = TeX::TabularX.new(**table_options)

        table.title = link_month(month.name, month:)
        table.add_row(header)

        week_rows.each { |row| table.add_row(row) }

        "\\adjustbox{valign=t}{#{table}}"
      end

      private

      def table_options
        {
          width: parameters.width,
          format:,
          vertical_stretch: parameters.vertical_stretch,
          horizontal_spacing: parameters.horizontal_spacing
        }.compact
      end

      def format
        return 'Y' * 7 unless parameters.show_week_numbers

        return "Y|#{'Y' * 7}" if week_number_placement == :left

        "#{'Y' * 7}|Y"
      end

      def header
        row = month.weekdays_one_letter

        return row unless parameters.show_week_numbers

        return ['W'] + row if week_number_placement == :left

        row + ['W']
      end

      def week_rows
        month.weeks.map do |week|
          row = week.days.map { |day| format_day(day) }
          next row unless parameters.show_week_numbers

          row.unshift(link_week(week.number, week:)) if week_number_placement == :left
          row.push(link_week(week.number, week:)) if week_number_placement == :right

          row
        end
      end

      def format_day(day)
        return '' unless day
        return "{#{link_day(day.mday, day:)}}" unless day == parameters.highlight_day&.date

        cell = TeX::Cell.new(day.mday)
        cell.selected = true

        link_day(cell, day:)
      end

      def week_number_placement
        parameters.week_number_placement.to_sym
      end
    end
  end
end
