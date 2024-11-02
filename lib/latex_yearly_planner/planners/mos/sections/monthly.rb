# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
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
