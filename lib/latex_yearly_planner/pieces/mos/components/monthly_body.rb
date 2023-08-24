# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class MonthlyBody < Component
          def generate(month)
            month.name
          end
        end
      end
    end
  end
end
