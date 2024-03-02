# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Breadcrumbs
      module Components
        class Header < Component
          def breadcrumbs(year:)
            table = TeX::TabularX.new(trailing_hline: true)
            table.add_row([TeX::Cell.new(year).to_s])

            "#{table}#{nlnl}"
          end
        end
      end
    end
  end
end
