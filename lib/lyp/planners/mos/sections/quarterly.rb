# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Quarterly
          attr_accessor :i18n, :overseer

          def initialize(i18n:, overseer:, **_rest)
            self.i18n = i18n
            self.overseer = overseer
          end

          def register(manifest)
            range.each do |quarter|
              manifest.register_source(quarter.id)
            end
          end

          def generate(planner, manifest)
            range.each do |quarter|
              page = Pages::Quarterly.new(i18n:, manifest:, quarter:)

              planner.add_page(
                title: page.title,
                content: page.content,
                highlight_quarters: [quarter]
              )
            end
          end

          private

          def range = overseer.start_date.quarter..overseer.end_date.quarter
        end
      end
    end
  end
end
