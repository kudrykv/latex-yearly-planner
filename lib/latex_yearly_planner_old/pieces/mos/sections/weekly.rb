# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Weekly < Section
          def iterations
            all_weeks.map { |week| [week] }
          end
        end
      end
    end
  end
end
