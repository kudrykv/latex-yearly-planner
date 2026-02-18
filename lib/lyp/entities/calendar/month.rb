# frozen_string_literal: true

module LYP
  module Entities
    module Calendar
      class Month
        attr_accessor :weekday_start, :day

        def initialize(weekday_start:, day:)
          raise InternalError unless day.is_a? Day

          self.weekday_start = weekday_start
          self.day = day.beginning_of_month
        end
      end

    end
  end
end
