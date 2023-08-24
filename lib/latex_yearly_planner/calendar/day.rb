# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Day
      attr_reader :date

      def initialize(date)
        @date = date
      end

      def name
        date.strftime('%A, %-d')
      end

      def respond_to_missing?(...)
        date.respond_to?(...)
      end

      def method_missing(...)
        date.send(...)
      end
    end
  end
end
