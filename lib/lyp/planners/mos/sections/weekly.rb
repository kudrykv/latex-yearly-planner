# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Weekly
          attr_accessor :name, :i18n, :overseer, :weekday_start, :first_week_day, :last_week_day

          def initialize(name:, i18n:, overseer:, **_rest)
            self.name = name
            self.i18n = i18n
            self.overseer = overseer
            self.weekday_start = overseer.weekday_start
            self.first_week_day = overseer.start_date.beginning_of_month.beginning_of_week
            self.last_week_day = overseer.end_date.end_of_month.end_of_week
          end

          def registered_section_name = name

          def register(manifest)
            weeks.each do |week|
              manifest.register_source(week.id)
            end
          end

          def generate(planner, manifest)
            weeks.each do |week|
              weekly = Pages::Weekly.new(i18n:, manifest:, week:)

              planner.add_page(
                title: weekly.title,
                content: weekly.content,
                highlight_months: week.in_months,
                highlight_quarters: week.in_quarters
              )
            end
          end

          private

          def weeks
            (first_week_day..last_week_day).each_slice(7).map(&:first).map do |day|
              Entities::Calendar::Week.new(weekday_start:, day:)
            end
          end
        end
      end
    end
  end
end
