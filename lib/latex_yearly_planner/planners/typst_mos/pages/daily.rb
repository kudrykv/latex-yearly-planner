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
                [*#{i18n.t("calendar.weekdays.full.#{day.name.downcase}")}*, #{i18n.t("calendar.month.#{day.month.name.downcase}")}],
                link(<#{day.week.id}>, [#{i18n.t('calendar.weekdays.full.week')} #{day.week.number}]),
              )<#{day.id}>]
            TYPST
          end

          def content(day)
            <<~TYPST
              grid(
                columns: (4.5cm, #{params.get(:gap_width)}, 1fr),
                stack(
                  dir: ttb,
                  spacing: 5mm,
                  table(
                    columns: 1fr,
                    inset: 0mm,
                    stroke: (_, y) =>
                      if calc.even(y) { ( bottom: 0.4pt + black ) }
                      else { ( bottom: 0.4pt + gray ) },
                    table.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t('schedule')}]))),
                    #{schedule},
                    #{params.get(:schedule_trailing_30min) ? 'box(height: 5mm)' : ''}
                  ),
                  #{maybe_little_calendar}
                ),
                [],
                stack(
                  dir: ttb,
                  spacing: 5mm,
                  table(
                    columns: 1fr,
                    inset: 0mm,
                    stroke: (_, _) => (bottom: 0.4pt + black),
                    table.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t('top_priorities')}]))),
                    #{top_priorities}
                  ),

                  box(height: 5mm, width: 100%, stroke: (bottom: 1pt), align(horizon, [#{i18n.t('daily_notes')}])),
                  box(height: #{params.get(:notes_height)}, width: 100%, rect_pattern(#{params.get(:pattern)})),

                  box(height: 5mm, width: 100%, stroke: (bottom: 1pt), align(horizon, [#{i18n.t('personal_notes')}])),
                  box(height: #{params.get(:personal_notes_height)}, width: 100%, rect_pattern(#{params.get(:pattern)})),
                )
              )
            TYPST
          end

          private

          def schedule
            (params.get(:schedule_from_hour)..params.get(:schedule_to_hour)).map do |hour|
              <<~TYPST
                box(height: 5mm, align(horizon, [#{hour}])), box(height: 5mm)
              TYPST
            end.join(",\n")
          end

          def maybe_little_calendar
            return '' unless params.get(:enable_little_calenar)

            <<~TYPST
              #{Xtypst::LittleCalendar.new(day.month, i18n:, **params.object(:little_calendar)).to_typst},
            TYPST
          end

          def top_priorities
            (['box(height: 5mm, align(horizon, [$square.stroked$]))'] * params.get(:priorities_number)).join(",\n")
          end
        end
      end
    end
  end
end
