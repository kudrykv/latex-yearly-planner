# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Daily
          def initialize(name:, i18n:, configurator:, **params)
            self.name = name
            self.i18n = i18n
            self.configurator = configurator
            self.params = params
          end

          def registered_section_name = name

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

          attr_accessor :name, :i18n, :configurator, :params

          def range = configurator.start_date..configurator.end_date
        end
      end
    end
  end
end
