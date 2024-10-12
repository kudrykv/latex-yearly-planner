# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Pages
        class Title < Page
          def generate(title, _page_number)
            <<~HTML
              <table class="page">
                  <tr><td><center style="font-size: 8em">#{title}</center></td></tr>
              </table>
            HTML
          end
        end
      end
    end
  end
end
