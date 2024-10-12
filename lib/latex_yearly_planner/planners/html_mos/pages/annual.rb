# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Pages
        class Annual < Page
          def generate(months_rows, _page_number)
            <<~HTML
              <table class="page">
                <tr><td>title</td></tr>
                <tr>
                  <td>
                    <table class='annual-table'>#{make_rows(months_rows)}</table>
                  </td>
                </tr>
              </table>
            HTML
          end

          private

          def make_rows(months_rows)
            months_rows.map { |row| "<tr>#{make_row(row)}</tr>" }.join
          end

          def make_row(row)
            row.map { |month| "<td>#{little_calendar(month)}</td>" }.join
          end

          def little_calendar(month)
            Html::LittleCalendar.new(month, **config[:planner][:objects][:little_calendar]).to_html
          end
        end
      end
    end
  end
end
