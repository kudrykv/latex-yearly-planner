# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class MonthlyHeader < Header
          def generate(month)
            [
              top_table(month:),
              hfill,
              title(month),
              hrule,
              margin_note(highlight_quarters: [month.quarter], highlight_months: [month]),
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          def title(month)
            target_month(TeX::TextSize.new(month.name).huge, month:)
          end
        end
      end
    end
  end
end
