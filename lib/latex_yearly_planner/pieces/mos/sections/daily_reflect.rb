# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class DailyReflect < Section
          def iterations
            all_days.map { |day| [day] }
          end
        end
      end
    end
  end
end