# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Header
          def generate
            "#{top_table}" \
              '\\hfill{}' \
              "#{title}" \
              '\\hrule{}' \
              "#{margin_note}" \
              "\n\\vspace{#{param(:header, :skip)}}\n\n"
          end

          private

          def title
            TeX::TextSize.new(year).huge
          end

          def year
            Date.parse(param(:start_date)).year
          end
        end
      end
    end
  end
end
