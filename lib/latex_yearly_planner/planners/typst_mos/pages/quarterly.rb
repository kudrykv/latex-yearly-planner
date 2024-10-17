# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Quarterly < Face
          def title(quarter, _page_number)
            <<~TYPST
              [Q#{quarter.number}]
            TYPST
          end

          def content(quarter, _page_number)
            months = quarter
              .months
              .map { |month| Xtypst::LittleCalendar.new(month, **params.object(:little_calendar)).to_typst }.join(', ')

            <<~TYPST
              grid(
                columns: (#{params.get(:months_width)}, 5mm, 1fr),
                rows: 1fr,
                vert_stack_bottom_outset(#{months}),
                [],
                dotted_rect
              )
            TYPST
          end
        end
      end
    end
  end
end
