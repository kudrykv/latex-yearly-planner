# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Schedule
      attr_reader :from, :to

      def initialize(**options)
        @from = Time.parse(options.fetch(:from, '10:00'))
        @to = Time.parse(options.fetch(:to, '18:00'))

        raise ArgumentError, 'from must be before to' if @from >= @to
        raise ArgumentError, 'from must end with :00 or :30' unless (@from.min % 30).zero?
        raise ArgumentError, 'to must end with :00 or :30' unless (@to.min % 30).zero?
      end

      def to_s
        range.map do |time|
          next hour_line(time) if time.min.zero?

          half_hour_line
        end
             .join
      end

      private

      def range
        arr = [from]

        arr << (arr.last + 30.minutes) while arr.last < to

        arr
      end

      def hour_line(time)
        "\\mbox{\\vphantom{\\rule{0pt}{5mm}}\\raisebox{1mm}{#{time.hour}}}\\myLinePlain"
      end

      def half_hour_line
        '\\vskip5mm\\myLineGray'
      end
    end
  end
end
