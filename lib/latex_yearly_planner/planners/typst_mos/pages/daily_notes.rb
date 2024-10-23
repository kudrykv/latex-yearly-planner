# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class DailyNotes < Face
          attr_reader :day

          def set(day)
            @day = day

            self
          end

          def title
            <<~TYPST
              [#grid(
                columns: 2,
                rows: (1fr, 1fr),
                inset: 0mm,
                align: left,
                grid.cell(
                  rowspan: 2,
                  stroke: (right: 0.4pt),
                  pad(right: 2mm, link(<#{day.id}>, text(#{params.get(:heading_size)})[#{day.day}]))
                ),
                pad(
                  left: 2mm,
                  bottom: 1mm,
                  [*#{i18n.t("calendar.weekdays.full.#{day.name.downcase}")}*]
                ),
                pad(left: 2mm, top: 1mm, [#{i18n.t("calendar.month.#{day.month.name.downcase}")}]),
              )<mdn-#{day.id}>]
            TYPST
          end

          def content
            <<~TYPST
              rect_pattern(#{params.get(:pattern)})
            TYPST
          end

          def extra_menu_items
            return [] unless params.section_enabled?(:weekly)

            ["link(<#{day.week.id}>, [#{i18n.t('calendar.weekdays.full.week')} #{day.week.number}])"]
          end
        end
      end
    end
  end
end
