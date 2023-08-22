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
    end
  end
end
