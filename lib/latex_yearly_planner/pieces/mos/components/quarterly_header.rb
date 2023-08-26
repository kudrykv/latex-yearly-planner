# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyHeader < Header
          def generate(quarter)
            [
              top_table,
              hfill,
              title(quarter),
              hrule,
              margin_note(highlight_quarters: [quarter]),
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          def title(quarter)
            TeX::TextSize.new(quarter.name).huge
          end
        end
      end
    end
  end
end
