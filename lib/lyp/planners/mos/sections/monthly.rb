# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Monthly
          attr_accessor :i18n, :overseer, :params

          def initialize(i18n:, overseer:, **_rest)
            self.i18n = i18n
            self.overseer = overseer
          end

          def register(manifest)
            range.each do |month|
              manifest.register_source(month.id)
            end
          end

          def generate(planner, manifest)
            range.each do |month|
              planner.add_page(
                title: "text(size: 18pt)[#{i18n.t("months.full.#{month.name}")}<#{month.id}>]",
                content: "[later]",
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
