# frozen_string_literal: true

module LatexYearlyPlanner
  module Xtypst
    class LittleCalendarRow
      DEFAULT_PARAMETERS = {
        week_with_numbers: true,
        link_to_week: true,
        week_number_placement: 'left',
        highlight_day: nil
      }.freeze

      attr_reader :week, :parameters

      def initialize(week, **parameters)
        @week = week
        @parameters = DEFAULT_PARAMETERS.merge(parameters.compact)
      end

      def to_typst
        row.join(', ')
      end

      private

      def row
        return row_internal unless parameters[:week_with_numbers]

        add_week!

        row_internal
      end

      def add_week!
        return row_internal.unshift(week_label) if parameters[:week_number_placement] == 'left'

        row_internal.push(week_label)
      end

      def week_label
        return "[#{week.number}]" unless parameters[:link_to_week]

        "link(<#{week.id}>, [#{week.number}])"
      end

      def row_internal
        @row_internal ||= week.days.map(&method(:map_day))
      end

      def map_day(day)
        return '[]' unless day
        return "link(<#{day.id}>, [#{day.day}])" if parameters[:highlight_day] != day

        "table.cell(fill: black, link(<#{day.id}>, text(white)[#{day.day}]))"
      end
    end
  end
end
