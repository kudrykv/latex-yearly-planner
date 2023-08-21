# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class CalendarLittle
      def initialize(month, width: '\\textwidth', show_week_numbers: true, week_number_placement: :left)
        @month = month
        @width = width
        @show_week_numbers = show_week_numbers
        @week_number_placement = week_number_placement.downcase.to_sym
      end

      def to_s
        table = LatexYearlyPlanner::TeX::TabularX.new

        table.title = month.name
        table.width = width
        table.format = format
        table.add_row(header)

        table.to_s
      end

      private

      attr_reader :month, :width, :show_week_numbers, :week_number_placement

      def header
        row = month.weekdays_one_letter

        return ['W'] + row if show_week_numbers && week_number_placement == :left

        row + ['W']
      end

      def format
        return 'Y' * 7 unless show_week_numbers

        return "Y|#{'Y' * 7}" if week_number_placement == :left

        "#{'Y' * 7}|Y"
      end
    end
  end
end
