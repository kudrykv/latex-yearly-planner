# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Monthly < Face
          attr_reader :month

          def set(month)
            @month = month

            self
          end

          def title
            "text(#{params.get(:heading_size)})[#{month.name}#label(\"#{month.id}\")]"
          end

          def content
            <<~TYPST
              stack(
                dir: ttb,
                spacing: #{params.get(:gap_width)},
                #{Xtypst::LargeCalendar.new(month, **params.object(:large_calendar)).to_typst},
                rect_pattern(#{params.get(:pattern)})
              )
            TYPST
          end

          def top_menu_month
            month
          end

          def highlight_side_menu_months
            [month]
          end
        end
      end
    end
  end
end
