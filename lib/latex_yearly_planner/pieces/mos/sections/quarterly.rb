# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Quarterly < Section
          def iterations
            all_quarters.map { |quarter| [quarter] }
          end
        end
      end
    end
  end
end
