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
              "#{margin_note(highlight_quarters: [month.quarter], highlight_months: [month])}" \
              "\n\\vspace{#{param(:header, :skip)}}\n\n"
          end

          def title(month)
            TeX::TextSize.new(month.name).huge
          end
        end
      end
    end
  end
end
