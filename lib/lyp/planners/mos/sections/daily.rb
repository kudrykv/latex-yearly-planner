# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Daily
          attr_accessor :i18n, :overseer, :params

          def initialize(i18n:, overseer:, **params)
            self.i18n = i18n
            self.overseer = overseer
            self.params = params
          end

          def register(manifest)
            range.each do |date|
              manifest.register_source(date.id)
            end
          end

          def generate(planner, manifest)
            range.each do |day|
              planner.add_page(title: title(manifest, day), content: content(manifest, day))
            end
          end

          private

          def range = overseer.start_date..overseer.end_date

          def title(manifest, day)
            page(manifest, day).title
          end

          def content(manifest, day)
            page(manifest, day).content
          end

          def page(manifest, day)
            Pages::Daily.new(i18n:, manifest:, day:, debug: overseer.debug?, **params)
          end
        end
      end
    end
  end
end
