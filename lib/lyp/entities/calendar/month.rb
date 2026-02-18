# frozen_string_literal: true

module LYP
  module Entities
    module Calendar
      class Month
        include Comparable

        attr_accessor :weekday_start, :day

        def initialize(weekday_start:, day:)
          raise InternalError unless day.is_a? Day

          self.weekday_start = weekday_start
          self.day = day.beginning_of_month
        end

        def id = @id ||= "month-#{day.id}"

        def succ = @succ ||= Month.new(weekday_start:, day: day.next_month)

        def <=>(other)
          raise ArgumentError, "must be Month" unless other.is_a? Month
          raise ArgumentError, "weekday start must match" unless weekday_start == other.weekday_start

          day <=> other.day
        end

        def name = @name ||= day.strftime("%B").downcase

        def to_s = "#{day.strftime("%Y, %B")} (wd: #{weekday_start})"
      end
    end
  end
end
