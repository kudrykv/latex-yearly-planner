# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Quarterly < Face
          def title(quarter)
            <<~TYPST
              [Q#{quarter.number}#label("Q#{quarter.year}-#{quarter.number}")]
            TYPST
          end

          def content(quarter)
            months = quarter.months.map do |month|
              Xtypst::LittleCalendar.new(month, **params.object(:little_calendar)).to_typst
            end.join(', ')

            <<~TYPST
              grid(
                columns: (#{params.get(:months_width)}, #{params.get(:gap_width)}, 1fr),
                rows: 1fr,
                vert_stack_bottom_outset(#{months}),
                [],
                rect_pattern(#{params.get(:pattern)})
              )
            TYPST
          end

          def side_menu_quarters(quarter)
            [quarter]
          end

          def top_menu_month(quarter)
            quarter.months.first
          end
        end
      end
    end
  end
end
