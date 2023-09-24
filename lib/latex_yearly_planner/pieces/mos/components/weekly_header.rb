# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class WeeklyHeader < Header
          def generate(week)
            [
              top_table(week:),
              hfill,
              title(week),
              hrule,
              margin_note(highlight_quarters: week.quarters, highlight_months: week.months),
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          def title(week)
            target_week(TeX::TextSize.new(week.name).huge, week:)
          end
        end
      end
    end
  end
end
