# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Pages
        class Annual < Page
          def generate(_months, _page_number)
            <<~HTML
              hello world
            HTML
          end
        end
      end
    end
  end
end
