# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Annual < Page
          def generate(month_rows, _page_number)
            <<~TYPST
              #grid(
                stroke: 0.4pt,
                columns: (1cm, 1fr),
                rows: (1cm, 1fr),
                grid.cell(
                  rowspan: 2,
                  #{temp}
                ),
                [test title], [##{typst_months(month_rows)}]
              )
            TYPST
          end

          private

          def typst_months(month_rows)
            <<~TYPST
              stack(
                dir: ttb,
                spacing: 1fr,
                #{month_rows.map { |row| row_stack(row) }.join(', ')}
              )
            TYPST
          end

          def row_stack(months)
            <<~TYPST
              stack(
                dir: ltr,
                spacing: 1fr,
                #{months.map { |month| Xtypst::LittleCalendar.new(month).to_typst }.join(', ')}
              )
            TYPST
          end

          def temp
            <<~TYPST
              rotate(
                  90deg,
                  origin: center + horizon,
                  reflow: true,
                  [
                  #table(
                  columns: (#{(['1fr'] * 4).join(', ')}, auto, #{(['1fr'] * 12).join(', ')}),
                  rows: 1fr,
                  align: horizon + center,
                  [Q1], [Q2], [Q3], [Q4],
                  [],
                  [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dec]
                  )]
                )
            TYPST
          end
        end
      end
    end
  end
end
