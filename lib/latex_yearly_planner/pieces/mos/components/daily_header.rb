# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyHeader < Header
          def generate(day)
            make_header(
              top_table(day:),
              title(day),
              highlight_quarters: [day.quarter],
              highlight_months: [day.month]
            )
          end

          def title(day)
            target_day(TeX::TextSize.new(day.name).huge, day:)
          end
        end
      end
    end
  end
end
