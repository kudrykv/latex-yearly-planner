# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class AnnualHeader < Header
          def generate(page, _months)
            make_header(top_table, title(page))
          end

          private

          def title(page)
            target_year(huge(year.to_s + XTeX::Dummy.new.to_s), page:, year:)
          end
        end
      end
    end
  end
end
