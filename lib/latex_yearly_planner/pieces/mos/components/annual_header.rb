# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Header
          def generate(_months)
            [
              top_table,
              hfill,
              title,
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          private

          def title
            target(start_month.year)
          end
        end
      end
    end
  end
end
