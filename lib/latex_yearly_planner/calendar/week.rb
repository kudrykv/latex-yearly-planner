# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Week
      attr_reader :days

      def initialize(days)
        @days = days
      end

      def name
        "Week #{number}"
      end

      def number
        shift = 0
        shift = 1 if days.compact.none?(&:monday?) && days.last.nil?

        days.compact.map(&:cweek).max + shift
      end

      def months
        days.compact.uniq(&:mon).map { |date| Month.new(date.beginning_of_month) }
      end

      def quarters
        days.compact.uniq(&:mon).map { |date| Quarter.new(date.beginning_of_quarter) }
      end
    end
  end
end
