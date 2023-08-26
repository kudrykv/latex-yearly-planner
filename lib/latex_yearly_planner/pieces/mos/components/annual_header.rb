# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Header
          def generate
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
            TeX::TextSize.new(start_month.year).huge
          end
        end
      end
    end
  end
end
