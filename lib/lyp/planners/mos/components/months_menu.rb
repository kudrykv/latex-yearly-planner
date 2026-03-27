# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class MonthsMenu
          attr_accessor :i18n, :manifest, :range, :highlighted

          def initialize(i18n:, manifest:, range:)
            self.i18n = i18n
            self.manifest = manifest
            self.range = range
            self.highlighted = []
          end

          def highlight(list = []) = self.highlighted = list

          def generate
            <<~TYPST.strip
              table(
                stroke: (x, y) => (left: 0.4pt, right: 0.4pt, bottom: 0.4pt),
                columns: (#{(["1fr"] * range.count).join(", ")}),
                rows: 1fr,
                align: horizon + center,

                #{months}
              )
            TYPST
          end

          def months = range.map(&method(:format)).join(",\n")

          def format(month)
            text = i18n.t("months.short.#{month.name}")
            text = "#padded_link(<#{month.id}>)[#{text}]" if manifest.source?(month.id)

            return "table.cell(fill: black, text(white)[#{text}])" if highlighted.include?(month)

            "table.cell([#{text}])"
          end
        end
      end
    end
  end
end
