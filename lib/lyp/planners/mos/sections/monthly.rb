# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Monthly
          attr_reader :section_name

          def initialize(section_name:, i18n:, configurator:, title_size:, month_params:, **_rest)
            self.section_name = section_name
            self.i18n = i18n
            self.configurator = configurator
            self.title_size = title_size
            self.month_params = month_params
          end

          def register(manifest)
            range.each do |month|
              manifest.register_source(month.id)
            end
          end

          def pages(manifest)
            range.map do |month|
              page = Pages::Monthly.new(i18n:, manifest:, month:, title_size:, month_params:)

              PageData.new(
                title: page.title,
                content: page.content,
                highlight_months: [month],
                highlight_quarters: [month.quarter]
              )
            end
          end

          private

          attr_writer :section_name
          attr_accessor :i18n, :configurator, :title_size, :month, :month_params

          def range = configurator.start_date.month..configurator.end_date.month
        end
      end
    end
  end
end
