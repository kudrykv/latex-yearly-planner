# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Daily < Face
          def title(day)
            <<~TYPST
              [#grid(
                columns: 2,
                rows: (1fr, 1fr),
                inset: 2mm,
                align: left,
                grid.cell(
                  rowspan: 2,
                  stroke: (right: 0.4pt),
                  text(#{params.get(:heading_size)})[#{day.day}]
                ),
                [*#{i18n.t("calendar.weekdays.full.#{day.name.downcase}")}*],
                [#{i18n.t("calendar.month.#{day.month.name.downcase}")}]
              )<#{day.id}>]
            TYPST
          end

          def content(day)
            "[hello]"
          end
        end
      end
    end
  end
end
