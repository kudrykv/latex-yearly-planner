# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Sections
        class Quarterly < Section
          def pages
            params.quarters
          end
        end
      end
    end
  end
end
