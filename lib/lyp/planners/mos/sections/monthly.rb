# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Monthly
          attr_accessor :i18n, :overseer, :title_size, :month, :month_params

          def initialize(i18n:, overseer:, title_size:, month_params:, **_rest)
            self.i18n = i18n
            self.overseer = overseer
            self.title_size = title_size
            self.month_params = month_params
          end

          def register(manifest)
            range.each do |month|
              manifest.register_source(month.id)
            end
          end

          def generate(planner, manifest)
            range.each do |month|
              page = Pages::Monthly.new(i18n:, manifest:, month:, title_size:, month_params:)

              planner.add_page(
                title: page.title,
                content: page.content,
                highlight_months: [month],
                highlight_quarters: [month.quarter]
              )
            end
          end

          private

          def range = overseer.start_date.month..overseer.end_date.month
        end
      end
    end
  end
end
