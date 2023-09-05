# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyHeader < Header
          def generate(quarter)
            [
              top_table(quarter:),
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
            target_quarter(TeX::TextSize.new(quarter.name).huge, quarter:)
          end
        end
      end
    end
  end
end
