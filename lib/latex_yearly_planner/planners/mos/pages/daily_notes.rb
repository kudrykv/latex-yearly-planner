# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
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
                  pad(right: 2mm, link(<#{day.id}>, text(#{heading_size})[#{day.day}]))
                ),
                pad(
                  left: 2mm,
                  bottom: 1mm,
                  [*#{day_name}*]
                ),
                pad(left: 2mm, top: 1mm, [#{month_name}]),
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

          private

          def heading_size
            params.get(:heading_size)
          end

          def day_name
            i18n.t("calendar.weekdays.full.#{day.name.downcase}")
          end

          def month_name
            i18n.t("calendar.month.#{day.month.name.downcase}")
          end
        end
      end
    end
  end
end
