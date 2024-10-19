# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Monthly < Face
          def title(month)
            "[#{month.name}#label(\"#{month.id}\")]"
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

          def top_menu_month(month)
            month
          end

          def side_menu_months(month)
            [month]
          end
        end
      end
    end
  end
end
