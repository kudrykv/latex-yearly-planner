# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Sections
        class Monthly < Section
          def pages
            params.months
          end
        end
      end
    end
  end
end
