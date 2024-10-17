# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Monthly < Face
          def title(month, _page_number)
            "[#{month.name}]"
          end

          def content(month, _page_number)
            <<~TYPST
              stack(
                dir: ttb,
                spacing: #{params.get(:gap_width)},
                #{Xtypst::LargeCalendar.new(month, **params.object(:large_calendar)).to_typst},
                rect_pattern(#{params.get(:pattern)})
              )
            TYPST
          end
        end
      end
    end
  end
end
