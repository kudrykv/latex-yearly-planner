# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Header
          def generate(page, _months)
            [
              top_table,
              hfill,
              title(page),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          private

          def title(page)
            target_year(huge(year), page:, year:)
          end
        end
      end
    end
  end
end
