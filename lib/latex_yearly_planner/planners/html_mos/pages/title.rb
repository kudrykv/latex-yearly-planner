# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Pages
        class Title < Page
          def generate(title, _page_number)
            title
          end
        end
      end
    end
  end
end
