# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class Annual < Section
          def pages_parameters
            all_months.each_slice(param(:months_per_page)).map { |months| [months] }
          end
        end
      end
    end
  end
end
