# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Schedule
      attr_reader :from, :to, :hour_format, :compensate_height, :width

      def initialize(**options)
        @from = Time.parse(options.fetch(:from, '10:00'))
        @to = Time.parse(options.fetch(:to, '18:00'))
        @hour_format = options.fetch(:hour_format, '24')
        @compensate_height = options.fetch(:compensate_height, nil)
        @width = options.fetch(:width, '\\linewidth')

        raise ArgumentError, 'from must be before to' if @from >= @to
        raise ArgumentError, 'from must end with :00 or :30' unless (@from.min % 30).zero?
        raise ArgumentError, 'to must end with :00 or :30' unless (@to.min % 30).zero?
        raise ArgumentError, 'hour_format must be 12 or 24' unless %w[12 24].include?(@hour_format)
      end

      def to_s
        TeX::Minipage.new(content: string_range, height:, width:, compensate_height:).to_s
      end

      private

      def height
        "#{range.size / 2.0}cm"
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
        "\\myLineGray\\mbox{\\vphantom{\\rule{0pt}{\\dimexpr5mm-.4pt}}\\raisebox{1.5mm}{#{hour(time)}}}\n"
      end

      def half_hour_line
        "\\myLineLightGray\\vskip\\dimexpr5mm-.4pt\n"
      end

      def hour(time)
        if hour_format == '12'
          time.strftime('%l %p')
        else
          time.hour
        end
      end
    end
  end
end
