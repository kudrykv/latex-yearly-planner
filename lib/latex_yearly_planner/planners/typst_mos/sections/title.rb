# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Sections
        class Title < Section
          def pages
            [title]
          end

          private

          def title
            params.get(:name)
          end
        end
      end
    end
  end
end