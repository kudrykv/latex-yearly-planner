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
      end
    end
  end
end
