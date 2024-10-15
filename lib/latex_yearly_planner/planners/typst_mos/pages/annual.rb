# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Annual < Page
          def generate(month_rows, _page_number)
            <<~TYPST
              #grid(
                columns: (#{mosnav[:width]}, 1fr),
                rows: (#{heading[:height]}, 1fr),
                grid.cell(
                  rowspan: 2,
                  pad(right: #{mosnav[:inset]}, #{temp})
                ),
                pad(bottom: #{heading[:inset]}, [#{title(month_rows)}]), [##{typst_months(month_rows)})]
              )
            TYPST
          end

          private

          def title(month_rows)
            first = month_rows.first.first
            last = month_rows.last.last

            <<~TYPST
              #table(
                columns: (auto, 1fr, auto),
                rows: 1fr,
                align: horizon + center,
                inset: 0mm,
                stroke: 0mm,
                [#{i18n.t("calendar.short.month.#{first.name.downcase}")}
                 #{first.year}
                 ---
                 #{i18n.t("calendar.short.month.#{last.name.downcase}")}
                 #{last.year}
                ],
                [],
                table(
                  columns: 2,
                  rows: 1fr,
                  align: horizon + center,
                  [Calendar], [Notes]
                )
              )
            TYPST
          end

          def typst_months(month_rows)
            <<~TYPST
              stack(
                dir: ttb,
                spacing: 1fr,
                #{month_rows.map { |row| row_stack(row) }.append('[]').join(', ')}
              )
            TYPST
          end

          def row_stack(months)
            <<~TYPST
              stack(
                dir: ltr,
                spacing: 1fr,
                #{months.map { |month| Xtypst::LittleCalendar.new(month, **params.object(:little_calendar)).to_typst }.join(', ')}
              )
            TYPST
          end

          def temp
            <<~TYPST
              rotate(
                  #{mosnav[:rotate]},
                  origin: center + horizon,
                  reflow: true,
                  [
                  #table(
                  columns: (#{(['1fr'] * 4).join(', ')}, auto, #{(['1fr'] * 12).join(', ')}),
                  rows: 1fr,
                  align: horizon + center,
                  #{mosnav_content}
                  )]
                )
            TYPST
          end

          def mosnav_content
            quarters = params.quarters.map { |q| "[#{i18n.t('calendar.one_letter.quarter')}#{q.number}]" }
            months = params.months.map { |m| "[#{i18n.t("calendar.short.month.#{m.name.downcase}")}]" }

            if mosnav[:reverse_array_internals]
              quarters.reverse!
              months.reverse!
            end

            return "#{quarters.join(', ')}, [], #{months.join(', ')}" unless mosnav[:reverse_arrays]

            "#{months.join(', ')}, [], #{quarters.join(', ')}"
          end

          def mosnav
            params.object(:mos_nav)
          end

          def heading
            params.object(:heading)
          end
        end
      end
    end
  end
end
