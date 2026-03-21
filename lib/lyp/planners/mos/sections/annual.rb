# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Annual
          attr_accessor :i18n, :overseer, :little_calendar

          def initialize(i18n:, overseer:, little_calendar:, **_rest)
            self.i18n = i18n
            self.overseer = overseer
            self.little_calendar = little_calendar
          end

          def register(manifest)
            manifest.register_source("calendar")
          end

          def generate(planner, _manifest)
            planner.add_page(
              title: "[Calendar]",
              content: "[later]"
            )
          end
        end
      end
    end
  end
end
