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

        def beginning_of_month = Day.new(weekday_start:, day: day.beginning_of_month)

        def end_of_month = Day.new(weekday_start:, day: day.end_of_month)

        def beginning_of_week(weekday_start = weekday_start)
          Day.new(weekday_start:, day: day.beginning_of_week(weekday_start))
        end

        def end_of_week(weekday_start = weekday_start)
          Day.new(weekday_start:, day: day.end_of_week(weekday_start))
        end
      end
    end
  end
end
