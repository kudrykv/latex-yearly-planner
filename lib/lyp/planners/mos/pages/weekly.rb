# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Weekly
          attr_accessor :i18n, :manifest, :week, :column_gutter

          def initialize(i18n:, manifest:, week:, column_gutter:)
            self.i18n = i18n
            self.manifest = manifest
            self.week = week
            self.column_gutter = column_gutter
          end

          def title
            "text(size: h1)[#{i18n.t("week_name_full")} #{week.number} <#{week.id}>]"
          end

          def content
            <<~TYPST.strip
              grid(
                columns: (1fr, 1fr, 1fr),
                rows: (4mm, 1fr, 4mm, 1fr, 4mm, 1fr),
                column-gutter: #{column_gutter},

                #{format_days(week.days[0...3])},
                grid.cell(colspan: 3, scratch_pad),
                #{format_days(week.days[3...6])},
                grid.cell(colspan: 3, scratch_pad),
                #{format_day(week.days[6])}, grid.cell(colspan: 2, stroke: (bottom: thick_stroke), [#{i18n.t("notes")}]),
                grid.cell(colspan: 3, scratch_pad)
              )
            TYPST
          end

          private

          def format_days(days)
            days.map(&method(:format_day)).join(", ")
          end

          def format_day(day)
            text = "[#{day.strftime("%A, %e")}]"
            text = "padded_link(<#{day.id}>, #{text})" if manifest.source?(day.id)

            "grid.cell(stroke: (bottom: thick_stroke), #{text})"
          end
        end
      end
    end
  end
end
