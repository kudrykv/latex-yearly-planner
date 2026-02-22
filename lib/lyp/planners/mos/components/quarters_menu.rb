# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class QuartersMenu
          attr_accessor :i18n, :range, :highlighted

          def initialize(i18n:, range:)
            self.i18n = i18n
            self.range = range
          end

          def highlight(list = []) = self.highlighted = list

          def generate
            <<~TYPST
              table(
                stroke: (x, y) => (left: 0.4pt, right: 0.4pt),
                columns: (#{(["1fr"] * range.count).join(", ")}),
                rows: 1fr,
                align: horizon + center,

                #{quarters}
              )
            TYPST
          end

          def quarters = range.map(&method(:format)).join(",\n")

          def format(quarter)
            if highlighted.include?(quarter)
              return "table.cell(fill: black, text(white)[#{i18n.t("quarters.short")}#{quarter.number}])"
            end

            "table.cell([#{i18n.t("quarters.short")}#{quarter.number}])"
          end
        end
      end
    end
  end
end
