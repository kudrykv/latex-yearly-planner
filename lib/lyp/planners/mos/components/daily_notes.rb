# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class DailyNotes
          attr_accessor :i18n

          def initialize(i18n:, **_rest)
            self.i18n = i18n
          end

          def generate
            <<~TYPST.strip
              grid(
                columns: 1fr,
                rows: (5.15mm, 1fr),
                grid.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t("top_priorities")}]))),
                rect_pattern(dotted)
              )
            TYPST
          end
        end
      end
    end
  end
end
