# frozen_string_literal: true

module LYP
  module Entities
    module Calendar
      class Quarter
        include Comparable

        attr_accessor :weekday_start, :day

        def initialize(weekday_start:, day:)
          self.weekday_start = weekday_start
          self.day = day.beginning_of_quarter
        end

        def number = day.quarter_number

        def to_s = "Q#{number} (wd: #{weekday_start})"

        def succ = @succ ||= Quarter.new(weekday_start:, day: day.next_quarter)

        def <=>(other)
          raise ArgumentError, "must be Quarter" unless other.is_a? Quarter
          raise ArgumentError, "weekday start must match" unless other.weekday_start == weekday_start

          day <=> other.day
        end

        def eql?(other)
          return false unless other.is_a? Quarter

          weekday_start.eql?(other.weekday_start) && day.eql?(other.day)
        end

        def hash = [weekday_start, day].hash
      end
    end
  end
end
