# frozen_string_literal: true

module LYP
  module Entities
    module Calendar
      class Week
        attr_accessor :weekday_start, :day

        def initialize(weekday_start:, day:)
          raise InternalError unless day.is_a? Day

          self.weekday_start = weekday_start
          self.day = day
        end

        def id = @id ||= to_s

        def number = @number ||= day.strftime("%V").to_i

        def to_s = @to_s ||= day.strftime("%GW%V")

        def days = @days ||= (0..6).map { |i| day + i }

        def in_months
          first = days.first
          last = days.last

          [first.month, last.month].uniq
        end
      end
    end
  end
end
