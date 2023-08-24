# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Quarter
      attr_reader :date

      def initialize(date)
        @date = date
      end

      def ==(other)
        date == other&.date
      end

      def name
        "Q#{number}"
      end

      def number
        (date.mon / 3.0).ceil
      end

      def months
        @months ||= (0..2).map { |month_number| Month.new(date + month_number.month) }
      end
    end
  end
end
