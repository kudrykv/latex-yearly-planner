# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyReflectHeader < Header
          def generate(day)
            make_header(
              top_table(day:),
              title(day),
              highlight_quarters: [day.quarter],
              highlight_months: [day.month]
            )
          end

          def title(day)
            link_day(target_reflect(TeX::TextSize.new(day.name).huge, day:), day:)
          end
        end
      end
    end
  end
end
