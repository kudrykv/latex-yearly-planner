# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Weekly
          attr_accessor :i18n, :manifest, :week

          def initialize(i18n:, manifest:, week:)
            self.i18n = i18n
            self.manifest = manifest
            self.week = week
          end

          def title
            "[#{i18n.t("week_name_full")} #{week.number} <#{week.id}>]"
          end

          def content
            <<~TYPST.strip
              grid(
                columns: (1fr, 1fr, 1fr),
                rows: (4mm, 1fr, 4mm, 1fr, 4mm, 1fr),

                #{format_days(week.days[0...3])},
                grid.cell(colspan: 3, rect_pattern(dotted)),
                #{format_days(week.days[3...6])},
                grid.cell(colspan: 3, rect_pattern(dotted)),
                #{format_day(week.days[6])}, [], [],
                grid.cell(colspan: 3, rect_pattern(dotted))
              )
            TYPST
          end

          private

          def format_days(days)
            days.map(&method(:format_day)).join(", ")
          end

          def format_day(day)
            return box_day(day) unless manifest.source?(day.id)

            "link(<#{day.id}>, #{box_day(day)})"
          end

          def box_day(day)
            <<~TYPST.strip
              box(
                stroke: (bottom: 0.8pt),
                width: 95%,
                inset: (bottom: 4pt),
                outset: 0pt
              )[#{day.strftime("%A, %e")}]
            TYPST
          end
        end
      end
    end
  end
end
