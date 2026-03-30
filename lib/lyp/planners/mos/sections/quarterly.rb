# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Quarterly
          attr_reader :section_name

          def initialize(section_name:, i18n:, configurator:, months_column:, **other)
            self.section_name = section_name
            self.i18n = i18n
            self.configurator = configurator
            self.months_column = months_column.to_sym
            self.little_calendar = (configurator.dig(:planner, :params, :little_calendar) || {})
                                   .merge(other[:little_calendar] || {})
          end

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

          attr_writer :section_name
          attr_accessor :i18n, :configurator, :months_column, :little_calendar

          def range = configurator.start_date.quarter..configurator.end_date.quarter
        end
      end
    end
  end
end
