# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Pages
        class Quarterly < Page
          def generate(quarter, _page_number)
            text = <<~HTML
              <table class="page">
                <tr>
                  <td class="writing90" rowspan=4>hello world</td>
                  <td colspan=2>#{heading_name(quarter)}</td>
                </tr>
                <tr>
                  <td>#{Html::LittleCalendar.new(quarter.months[0]).to_html}</td>
                  <td rowspan=3 class="dotted" style="width: 7cm"></td>
                </tr>
                <tr>
                  <td>#{Html::LittleCalendar.new(quarter.months[1]).to_html}</td>
                </tr>
                <tr>
                  <td>#{Html::LittleCalendar.new(quarter.months[1]).to_html}</td>
                </tr>
              </table>
            HTML

            text * 250
          end

          private

          def heading_name(quarter)
            "Q#{quarter.number}"
          end
        end
      end
    end
  end
end
