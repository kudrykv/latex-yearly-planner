# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Sections
        class Quarterly < Section
          def pages
            params.quarters
          end

          private


        end
      end
    end
  end
end
