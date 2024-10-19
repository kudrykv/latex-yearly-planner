# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Monthly < Face
          def title(month)
            "[#{month.name}]"
          end

          def content(month)
            <<~TYPST
              stack(
                dir: ttb,
                spacing: #{params.get(:gap_width)},
                #{Xtypst::LargeCalendar.new(month, **params.object(:large_calendar)).to_typst},
                rect_pattern(#{params.get(:pattern)})
              )
            TYPST
          end

          def current_months(month)
            [month]
          end
        end
      end
    end
  end
end
