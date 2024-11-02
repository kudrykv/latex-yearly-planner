# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Sections
        class Weekly < Section
          def pages
            params.weeks
          end
        end
      end
    end
  end
end
