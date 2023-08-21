# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class CalendarLittle
      def initialize(month)
        @month = month
      end

      private

      attr_reader :month
    end
  end
end
