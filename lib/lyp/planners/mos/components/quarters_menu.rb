# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class QuartersMenu
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
                stroke: (x, y) => (left: regular_stroke, right: regular_stroke, bottom: regular_stroke),
                columns: (#{(["1fr"] * range.count).join(", ")}),
                rows: 1fr,
                align: horizon + center,

                #{quarters}
              )
            TYPST
          end

          def quarters = range.map(&method(:format)).join(",\n")

          def format(quarter)
            text = "#{i18n.t("quarters.short")}#{quarter.number}"
            text = "#padded_link(<#{quarter.id}>)[#{text}]" if manifest.source? quarter.id

            return "table.cell(fill: black, text(white)[#{text}])" if highlighted.include?(quarter)

            "table.cell([#{text}])"
          end
        end
      end
    end
  end
end
