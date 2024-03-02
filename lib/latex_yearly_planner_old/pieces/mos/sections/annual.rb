# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Annual < Section
          def iterations
            all_months.each_slice(param(:months_per_page)).map.with_index(1) { |months, page| [page, months] }
          end
        end
      end
    end
  end
end
