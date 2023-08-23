# frozen_string_literal: true

module LatexYearlyPlanner
  module Calendar
    class Quarter
      attr_reader :date

      def initialize(date)
        @date = date
      end

      def name
        "Q#{number}"
      end

      def number
        (date.mon / 3.0).ceil
      end

      def months
        @months ||= begin
          (0..2).map do |month_number|
            Month.new(date + month_number.month)
          end
        end
      end
    end
  end
end
