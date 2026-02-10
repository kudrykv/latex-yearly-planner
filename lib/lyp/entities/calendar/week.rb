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

        def to_s = day.strftime('%GW%V')
      end
    end
  end
end
