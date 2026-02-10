# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        module Sections
          class Weekly
            attr_accessor :overseer

            def initialize(overseer:, **_rest)
              self.overseer = overseer
            end

            def generate
              weeks.map do |week|
                week
              end
            end

            private

            def weeks
              first_week_day.upto(last_week_day).each_slice(7).map(&:first)
            end

            def first_week_day = overseer.start_date.beginning_of_month.beginning_of_week(overseer.weekday_start)

            def last_week_day = overseer.end_date.end_of_month.end_of_week(overseer.weekday_start)
          end
        end
      end
    end
  end
end
