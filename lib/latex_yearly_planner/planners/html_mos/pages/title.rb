# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Pages
        class Title < Page
          def generate(title, _page_number)
            <<~HTML
                            <table class="page" style="border-collapse: collapse; border: 1px solid black">
                  <tr>
                      <td>
                          #{title}
                      </td>
              </table>
            HTML
          end
        end
      end
    end
  end
end
