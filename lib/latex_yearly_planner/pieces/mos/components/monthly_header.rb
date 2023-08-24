# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class MonthlyHeader < Header
          def generate(month)
            "#{top_table}" \
              '\\hfill{}' \
              "#{title(month)}" \
              '\\hrule{}' \
              "#{margin_note(highlight_month: month)}" \
              "\\medskip\n"
          end

          def title(month)
            TeX::TextSize.new(month.name).huge
          end
        end
      end
    end
  end
end
