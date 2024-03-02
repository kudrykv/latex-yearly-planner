# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Monthly < Section
          def iterations
            all_months.map { |month| [month] }
          end
        end
      end
    end
  end
end
