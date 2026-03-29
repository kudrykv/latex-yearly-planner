# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Daily
          attr_reader :section_name

          def initialize(section_name:, i18n:, configurator:, **params)
            self.section_name = section_name
            self.i18n = i18n
            self.configurator = configurator
            self.params = params
          end

          def register(manifest)
            range.each do |date|
              manifest.register_source(date.id)
            end
          end

          def pages(manifest)
            range.map do |day|
              page = Pages::Daily.new(i18n:, manifest:, day:, debug: configurator.debug?, **params)

              PageData.new(
                title: page.title,
                content: page.content,
                highlight_months: [day.month],
                highlight_quarters: [day.quarter]
              )
            end
          end

          private

          attr_writer :section_name
          attr_accessor :i18n, :configurator, :params

          def range = configurator.start_date..configurator.end_date
        end
      end
    end
  end
end
