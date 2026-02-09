# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Pages
        module DailyCallable
          def my_gap
            'box(height: 5mm)'
          end

          def my_schedule
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

          def my_little_calendar
            Xtypst::LittleCalendar.new(day.month, highlight_day: day, i18n:, **params.object(:little_calendar)).to_typst
          end

          def my_top_priorities
            <<~TYPST
              pad(bottom: 5mm, table(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, _) => (bottom: 0.4pt + luma(130)),
                table.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t('top_priorities')}]))),
                #{top_priorities_lines}
              ))
            TYPST
          end

          def my_notes
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

          def my_personal_notes
            <<~TYPST
              stack(
                dir: ttb,
                spacing: 5mm,
                box(height: 5mm, width: 100%, stroke: (bottom: 1pt), align(horizon, [#{i18n.t('personal_notes')}])),
                box(height: #{params.get(:personal_notes_height)}, width: 100%, rect_pattern(#{params.get(:pattern)})),
              )
            TYPST
          end

          private

          def schedule_lines
            (params.get(:schedule_from_hour)..params.get(:schedule_to_hour)).map do |hour|
              "box(height: 5mm, align(horizon, [#{pretty_hour(hour)}])), box(height: 5mm)"
            end.join(",\n")
          end

          def pretty_hour(hour)
            DateTime.parse("#{hour}:00").strftime(params.get(:schedule_strftime))
          end

          def top_priorities_lines
            (['box(height: 5mm, align(horizon, [$square.stroked$]))'] * params.get(:priorities_number)).join(",\n")
          end

          def more_daily_notes
            return '' unless params.section_enabled?(:daily_notes)

            return single_link_to_daily_notes if daily_pages_per_day == 1 || !want_explicit_links?

            explicit_links_to_daily_notes
          end

          def single_link_to_daily_notes
            " | #link(<mdn-#{day.id}-1>, [#{i18n.t('more_daily_notes')}])"
          end

          def explicit_links_to_daily_notes
            links = daily_pages_per_day.times.drop(1).map do |index|
              "#link(<mdn-#{day.id}-#{index + 1}>, [#{index + 1}])"
            end

            links.unshift("#link(<mdn-#{day.id}-1>, [#{i18n.t('more_daily_notes')}])")

            " | #{links.join(' ')}"
          end

          def daily_pages_per_day
            params.section!(:daily_notes).params.get(:pages_per_day) || 1
          end

          def want_explicit_links?
            params.get(:daily_notes_explicit_links)
          end

          def daily_reflect
            return '' unless params.section_enabled?(:daily_reflect)

            "#h(1fr) #link(<dr-#{day.id}>, [#{i18n.t('daily_reflect.name')}])"
          end
        end
      end
    end
  end
end
