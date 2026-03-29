# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Quarterly
          def initialize(name:, i18n:, overseer:, months_column:, little_calendar:, **_rest)
            self.name = name
            self.i18n = i18n
            self.overseer = overseer
            self.months_column = months_column.to_sym
            self.little_calendar = little_calendar
          end

          def registered_section_name = name

          def register(manifest)
            range.each do |quarter|
              manifest.register_source(quarter.id)
            end
          end

          def pages(manifest)
            range.map do |quarter|
              page = Pages::Quarterly.new(i18n:, manifest:, quarter:, months_column:, little_calendar:)

              PageData.new(
                title: page.title,
                content: page.content,
                highlight_quarters: [quarter]
              )
            end
          end

          private

          attr_accessor :name, :i18n, :overseer, :months_column, :little_calendar

          def range = overseer.start_date.quarter..overseer.end_date.quarter
        end
      end
    end
  end
end
