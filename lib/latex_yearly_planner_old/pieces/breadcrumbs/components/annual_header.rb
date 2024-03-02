# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Breadcrumbs
      module Components
        class AnnualHeader < Header
          def generate(page, _months)
            breadcrumbs(year: title(page))
          end

          private

          def title(page)
            target_year(large(year.to_s), page:, year:)
          end
        end
      end
    end
  end
end
