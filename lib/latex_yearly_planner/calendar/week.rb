# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Week
      attr_reader :weekday_start, :days

      def initialize(weekday_start:, days:)
        @weekday_start = weekday_start
        @days = days
      end

      def id
        ids.first
      end

      def ids
        compact = days.compact
        first = compact.first
        last = compact.last

        %W[week-#{number}-#{first.strftime('%Y-%m')} week-#{number}-#{last.strftime('%Y-%m')}].uniq
      end

      def number
        shift = 0
        shift = 1 if days.compact.none?(&:monday?) && days.last.nil?

        days.compact.map(&:cweek).last + shift
      end

      def months
        [days.first.month, days.last.month].uniq
      end

      def ==(other)
        return false unless other.is_a?(Week)

        weekday_start == other.weekday_start && days == other.days
      end
    end
  end
end
