# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualBody < Component
          def generate(months)
            "#{months.first}, #{months.last}"
          end
        end
      end
    end
  end
end
