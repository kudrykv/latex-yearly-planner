# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Sections
        class DailyReflect < Section
          def pages
            params.days
          end
        end
      end
    end
  end
end
