# frozen_string_literal: true

module LYP
  module Entities
    module Calendar
      class Day
        include Comparable
        extend Forwardable

        attr_accessor :weekday_start, :day

        def_delegators :@day, :year, :strftime

        def initialize(weekday_start:, day:)
          raise ArgumentError unless day.is_a?(Date)

          self.weekday_start = weekday_start
          self.day = day
        end

        def id = day.strftime("%Y-%m-%d")

        def beginning_of_month = Day.new(weekday_start:, day: day.beginning_of_month)

        def end_of_month = Day.new(weekday_start:, day: day.end_of_month)

        def next_month = Day.new(weekday_start:, day: day.next_month)

        def month = Month.new(weekday_start:, day: self)

        def quarter = Quarter.new(weekday_start:, day: self)

        def week = Week.new(weekday_start:, day: self.beginning_of_week)

        def quarter_number = day.quarter

        def beginning_of_quarter
          curr = day.beginning_of_month

          curr = (curr - 1).beginning_of_month until curr.quarter != (curr - 1).quarter

          Day.new(weekday_start:, day: curr)
        end

        def next_quarter = Day.new(weekday_start:, day: day.next_quarter)

        def beginning_of_week = Day.new(weekday_start:, day: day.beginning_of_week(weekday_start))

        def end_of_week = Day.new(weekday_start:, day: day.end_of_week(weekday_start))

        def month_day = day.mday

        def weekday_name = day.strftime("%A").downcase

        def +(other) = Day.new(weekday_start:, day: day + other.day)

        def succ = @succ ||= Day.new(weekday_start:, day: day.succ)

        def <=>(other)
          raise ArgumentError, "must be Day" unless other.is_a? Day
          raise ArgumentError, "weekday start must match" unless other.weekday_start == weekday_start

          day <=> other.day
        end

        def to_s = "#{day} (wd: #{weekday_start})"

        def hash = [weekday_start, day].hash

        def eql?(other)
          return false unless other.is_a? Day

          weekday_start.eql?(other.weekday_start) && day.eql?(other.day)
        end
      end
    end
  end
end
