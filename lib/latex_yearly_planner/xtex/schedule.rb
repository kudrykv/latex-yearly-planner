# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Schedule
      attr_reader :from, :to, :compensate_height

      def initialize(**options)
        @from = Time.parse(options.fetch(:from, '10:00'))
        @to = Time.parse(options.fetch(:to, '18:00'))
        @compensate_height = options.fetch(:compensate_height, nil)

        raise ArgumentError, 'from must be before to' if @from >= @to
        raise ArgumentError, 'from must end with :00 or :30' unless (@from.min % 30).zero?
        raise ArgumentError, 'to must end with :00 or :30' unless (@to.min % 30).zero?
      end

      def to_s
        # "\\fbox{#{TeX::Minipage.new(content: string_range, height: '10cm', compensate_height: '9pt')}}"
        "#{compensate}#{string_range}"
        # 'hello world'
      end

      private

      def compensate
        return '' if compensate_height.nil?

        "\\vspace{-#{compensate_height}}"
      end

      def string_range
        range.map do |time|
          next hour_line(time) if time.min.zero?

          half_hour_line
        end
             .join
      end

      def range
        arr = [from]

        arr << (arr.last + 30.minutes) while arr.last < to

        arr
      end

      def hour_line(time)
        "\\myLineGray\\mbox{\\vphantom{\\rule{0pt}{5mm}}\\raisebox{1mm}{#{time.hour}}}\n"
      end

      def half_hour_line
        "\\myLineLightGray\\vskip5mm\n"
      end
    end
  end
end
