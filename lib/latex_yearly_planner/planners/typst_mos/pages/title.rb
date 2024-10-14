# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Title < Page
          def generate(title, _page_number)
            title.to_s
          end
        end
      end
    end
  end
end
