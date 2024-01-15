# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class WeeklyHeader < Header
          def generate(week)
            make_header(
              top_table(week:),
              title(week),
              highlight_quarters: week.quarters,
              highlight_months: week.months
            )
          end

          def title(week)
            target_week(TeX::TextSize.new(week.name).huge, week:)
          end
        end
      end
    end
  end
end
