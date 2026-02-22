# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class DailyTopPriorities
          attr_accessor :i18n, :number

          def initialize(i18n:, number:)
            self.i18n = i18n
            self.number = number
          end

          def generate
            <<~TYPST
              pad(bottom: 5mm, table(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, _) => (bottom: 0.4pt),
                table.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t("top_priorities")}]))),
                #{top_priorities_lines}
              ))
            TYPST
          end

          private

          def top_priorities_lines
            (["box(height: 5mm, align(horizon, [$square.stroked$]))"] * number).join(",\n")
          end
        end
      end
    end
  end
end
