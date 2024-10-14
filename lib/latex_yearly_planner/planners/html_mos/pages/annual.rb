# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module HtmlMos
      module Pages
        class Annual < Page
          def generate(months_rows, _page_number)
            <<~HTML
              <table id="#{page_id}" class="page">
                <tr>
                  <td class="writing90" rowspan=2>hello world</td>
                  <td>#{heading_name}</td>
                </tr>
                <tr>
                  <td>
                    <table class='annual-table'>#{make_rows(months_rows)}</table>
                  </td>
                </tr>
              </table>
            HTML
          end

          private

          def heading_name
            first = params.months.first
            last = params.months.last

            return first.year if first.year == last.year && first.january? && last.december?

            "#{first.year}, #{i18n.t("calendar.short.month.#{first.name.downcase}")} — #{last.year}, #{i18n.t("calendar.short.month.#{last.name.downcase}")}"
          end

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
