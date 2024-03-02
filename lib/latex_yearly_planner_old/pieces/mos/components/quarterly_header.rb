# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyHeader < Header
          def generate(quarter)
            make_header(
              top_table(quarter:),
              title(quarter),
              highlight_quarters: [quarter]
            )
          end

          def title(quarter)
            target_quarter(TeX::TextSize.new(quarter.name).huge, quarter:)
          end
        end
      end
    end
  end
end
