# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class MonthlyHeader < Header
          def generate(month)
            make_header(
              top_table(month:),
              title(month),
              highlight_quarters: [month.quarter],
              highlight_months: [month]
            )
          end

          def title(month)
            target_month(TeX::TextSize.new(month.name).huge, month:)
          end
        end
      end
    end
  end
end
