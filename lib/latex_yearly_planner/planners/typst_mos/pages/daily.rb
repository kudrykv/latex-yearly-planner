# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Daily < Face
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
                  pad(right: 2mm, text(#{params.get(:heading_size)})[#{day.day}])
                ),
                pad(
                  left: 2mm,
                  bottom: 1mm,
                  [*#{i18n.t("calendar.weekdays.full.#{day.name.downcase}")}*]
                ),
                pad(left: 2mm, top: 1mm, [#{i18n.t("calendar.month.#{day.month.name.downcase}")}]),
              )<#{day.id}>]
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

          def extra_menu_items
            return [] unless params.section_enabled?(:weekly)

            ["link(<#{day.week.id}>, [#{i18n.t('calendar.weekdays.full.week')} #{day.week.number}])"]
          end

          def highlight_side_menu_months
            [day.month]
          end

          def highlight_side_menu_quarters
            [day.quarter]
          end

          def top_menu_month
            day.month
          end

          private

          def left_column
            "stack(dir: ttb, #{run_methods_of(:left_column_items)})"
          end

          def right_column
            "stack(dir: ttb, #{run_methods_of(:right_column_items)})"
          end

          def run_methods_of(column)
            params.get(column).map(&method(:send)).join(",\n")
          end

          def schedule
            <<~TYPST
              table(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, y) =>
                  if calc.even(y) { ( bottom: 0.4pt + black ) }
                  else { ( bottom: 0.4pt + gray ) },
                table.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t('schedule')}]))),
                #{schedule_lines},
                #{params.get(:schedule_trailing_30min) ? 'box(height: 5mm)' : ''}
              )
            TYPST
          end

          def schedule_lines
            (params.get(:schedule_from_hour)..params.get(:schedule_to_hour)).map do |hour|
              "box(height: 5mm, align(horizon, [#{hour}])), box(height: 5mm)"
            end.join(",\n")
          end

          def little_calendar
            Xtypst::LittleCalendar.new(day.month, highlight_day: day, i18n:, **params.object(:little_calendar)).to_typst
          end

          def top_priorities
            <<~TYPST
              pad(bottom: 5mm, table(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, _) => (bottom: 0.4pt + black),
                table.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t('top_priorities')}]))),
                #{top_priorities_lines}
              ))
            TYPST
          end

          def top_priorities_lines
            (['box(height: 5mm, align(horizon, [$square.stroked$]))'] * params.get(:priorities_number)).join(",\n")
          end

          def notes
            <<~TYPST
              stack(
                dir: ttb,
                spacing: 5mm,
                box(
                  height: 5mm, width: 100%, stroke: (bottom: 1pt),
                  align(horizon, [#{i18n.t('daily_notes')}#{more_daily_notes}#{daily_reflect}])
                ),
                box(height: #{params.get(:notes_height)}, width: 100%, rect_pattern(#{params.get(:pattern)})),
              )
            TYPST
          end

          def more_daily_notes
            return '' unless params.section_enabled?(:daily_notes)

            " | #link(<mdn-#{day.id}>, [#{i18n.t('more_daily_notes')}])"
          end

          def daily_reflect
            return '' unless params.section_enabled?(:daily_reflect)

            "#h(1fr) #link(<dr-#{day.id}>, [#{i18n.t('daily_reflect.name')}])"
          end

          def personal_notes
            <<~TYPST
              stack(
                dir: ttb,
                spacing: 5mm,
                box(height: 5mm, width: 100%, stroke: (bottom: 1pt), align(horizon, [#{i18n.t('personal_notes')}])),
                box(height: #{params.get(:personal_notes_height)}, width: 100%, rect_pattern(#{params.get(:pattern)})),
              )
            TYPST
          end
        end
      end
    end
  end
end
