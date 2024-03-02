# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Sections
        class Title < Section
          def pages
            []
          end

          private

          def title
            section_config
          end
        end
      end
    end
  end
end
