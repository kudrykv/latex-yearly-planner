# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class DailyReflect < Face
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
                  link(<#{day.id}>, [*#{i18n.t("calendar.weekdays.full.#{day.name.downcase}")}*,
                    #{i18n.t("calendar.month.#{day.month.name.downcase}")}])
                ),
                pad(left: 2mm, top: 1mm, link(<#{day.week.id}>, [#{i18n.t('calendar.weekdays.full.week')} #{day.week.number}])),
              )<dr-#{day.id}>]
            TYPST
          end

          def content
            <<~TYPST
              grid(
                columns: (#{params.get(:left_column_width)}, #{params.get(:gap_width)}, 1fr),
                #{left_column},
                [],
                #{right_column}
              )
            TYPST
          end

          private

          def left_column
            '[hello]'
          end

          def right_column
            '[world]'
          end
        end
      end
    end
  end
end
