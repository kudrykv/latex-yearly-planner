# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyReflectHeader < Header
          def generate(day)
            [
              top_table,
              hfill,
              title(day),
              hrule,
              margin_note(highlight_quarters: [day.quarter], highlight_months: [day.month]),
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          def title(day)
            target_reflect(TeX::TextSize.new(day.name).huge, day:)
          end
        end
      end
    end
  end
end
