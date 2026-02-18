# frozen_string_literal: true

module LYP
  module Entities
    module Calendar
      class Day
        attr_accessor :weekday_start, :day

        def initialize(weekday_start:, day:)
          self.weekday_start = weekday_start
          self.day = day
        end

        def id = day.strftime("%Y-%m-%d")

        def beginning_of_month = Day.new(weekday_start:, day: day.beginning_of_month)

        def end_of_month = Day.new(weekday_start:, day: day.end_of_month)

        def next_month = Day.new(weekday_start:, day: day.next_month)

        def beginning_of_week(wds = weekday_start)
          Day.new(weekday_start: wds, day: day.beginning_of_week(wds))
        end

        def end_of_week(wds = weekday_start)
          Day.new(weekday_start: wds, day: day.end_of_week(wds))
        end

        def upto(other_day)
          day.upto(other_day.day).map { |day| Day.new(weekday_start:, day:) }
        end

        def year = day.year

        def strftime(...) = day.strftime(...)

        def +(other) = Day.new(weekday_start:, day: day + other.day)

        def succ = Day.new(weekday_start:, day: day.succ)

        def <=>(other)
          raise ArgumentError, "must be Day" unless other.is_a? Day
          raise ArgumentError, "weekday start must match" unless other.weekday_start == weekday_start

          day <=> other.day
        end

        def to_s = "#{day} (wd: #{weekday_start})"
      end
    end
  end
end
