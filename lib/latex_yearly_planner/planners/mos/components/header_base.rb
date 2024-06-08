# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class HeaderBase < Component
          def quarters
            params.quarters
          end

          def months
            params.months
          end
        end
      end
    end
  end
end
