# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class Schedule
      attr_reader :from, :to, :hour_format, :width, :show_label, :line_height

      def initialize(**options)
        @from = Time.parse(options.fetch(:from, '10:00'))
        @to = Time.parse(options.fetch(:to, '18:00'))
        @hour_format = options.fetch(:hour_format, '24')
        @width = options.fetch(:width, '\\linewidth')
        @show_label = options.fetch(:show_label, false)
        @line_height = options.fetch(:line_height, '5mm')

        validate
      end

      def to_s
        TeX::AdjustBox.new(content:).to_s
      end

      private

      def validate
        raise ArgumentError, 'from must be before to' if from >= to
        raise ArgumentError, 'from must end with :00 or :30' unless (from.min % 30).zero?
        raise ArgumentError, 'to must end with :00 or :30' unless (to.min % 30).zero?
        raise ArgumentError, 'hour_format must be 12 or 24' unless %w[12 24].include?(hour_format)
      end

      def content
        "\\parbox{#{width}}{#{label}#{string_range.join}}"
      end

      def label
        return '' unless show_label

        "#{XTeX::MinHeight.new('5mm')}Schedule\\myLinePlain"
      end

      def height
        "#{range.size / 2.0}cm"
      end

      def string_range
        range.map do |time|
          next hour_line(time) if time.min.zero?

          half_hour_line(time)
        end
      end

      def range
        arr = [from]

        arr << (arr.last + 30.minutes) while arr.last < to

        arr
      end

      def hour_line(time)
        return Line.gray if time == to

        line = time == from && show_label ? '' : Line.gray

        "#{line}\n#{MinHeight.new(make_line_height)}#{hour(time)}\n"
      end

      def half_hour_line(time)
        return Line.light_gray if time == to

        "#{Line.light_gray}#{MinHeight.new(make_line_height)}\n"
      end

      def hour(time)
        if hour_format == '12'
          time.strftime('%l %p')
        else
          time.hour
        end
      end

      def make_line_height
        "\\dimexpr#{line_height}-.4pt"
      end
    end
  end
end
