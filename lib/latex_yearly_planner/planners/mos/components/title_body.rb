# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Components
        class TitleBody < Component
          def generate(name, _page_number)
            name
          end
        end
      end
    end
  end
end
