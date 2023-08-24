# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class WeeklyHeader < Header
          def generate(week)
            "#{top_table}" \
              '\\hfill{}' \
              "#{title(week)}" \
              '\\hrule{}' \
              "#{margin_note(highlight_quarters: week.quarters, highlight_months: week.months)}" \
              "\\medskip\n"
          end

          def title(week)
            TeX::TextSize.new(week.name).huge
          end
        end
      end
    end
  end
end