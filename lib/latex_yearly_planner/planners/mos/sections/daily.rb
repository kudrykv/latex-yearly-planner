# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Sections
        class Daily < Section
          def pages
            params.days
          end
        end
      end
    end
  end
end