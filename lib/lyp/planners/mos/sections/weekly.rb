# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Weekly
          attr_reader :section_name

          def initialize(section_name:, i18n:, configurator:, **_rest)
            self.section_name = section_name
            self.i18n = i18n
            self.configurator = configurator
            self.weekday_start = configurator.weekday_start
            self.first_week_day = configurator.start_date.beginning_of_month.beginning_of_week
            self.last_week_day = configurator.end_date.end_of_month.end_of_week
          end

          def register(manifest)
            weeks.each do |week|
              manifest.register_source(week.id)
            end
          end

          def pages(manifest)
            weeks.map do |week|
              weekly = Pages::Weekly.new(i18n:, manifest:, week:)

              PageData.new(
                title: weekly.title,
                content: weekly.content,
                highlight_months: week.in_months,
                highlight_quarters: week.in_quarters
              )
            end
          end

          private

          attr_writer :section_name
          attr_accessor :i18n, :configurator, :weekday_start, :first_week_day, :last_week_day

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
