# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Face < Page
          def generate
            <<~TYPST
              #grid(
                columns: (#{heading_columns}),
                rows: (#{heading[:height]}, 1fr),
                grid.cell(
                  rowspan: 2,
                  pad(right: #{mosnav[:side_pad]}, #{side_menu_layout})
                ),
                pad(bottom: #{heading[:bottom_pad]}, #{header}), #{content}
              )
            TYPST
          end

          def title
            raise NotImplementedError
          end

          def content
            raise NotImplementedError
          end

          def side_menu_quarters
            []
          end

          def side_menu_months
            []
          end

          def top_menu_month
            nil
          end

          def highlight_calendar?
            false
          end

          def annual_page_number(first_month)
            annual_params = params.planner_config.sections
                                  .find { |section| section.name == :annual }
                                  .params
            months_per_page = annual_params.get(:months_per_page)

            (annual_params.months.find_index(first_month) / months_per_page) + 1
          end

          private

          def header
            <<~TYPST
              table(
                columns: (auto, 1fr, auto),
                rows: 1fr,
                align: horizon + center,
                inset: 0mm,
                stroke: 0mm,
                #{title},
                [],
                #{menu_items}
              )
            TYPST
          end

          def side_menu_layout
            <<~TYPST
              rotate(
                #{mosnav[:rotate]},
                origin: center + horizon,
                reflow: true,
                table(
                  stroke: (x, y) => (left: 0.4pt, right: 0.4pt),
                  columns: (#{(['1fr'] * params.quarters.size).join(', ')}, auto, #{(['1fr'] * params.months.size).join(', ')}),
                  rows: 1fr,
                  align: horizon + center,
                  #{side_menu_content}
                )
              )
            TYPST
          end

          def side_menu_content
            quarters = params.quarters.map do |q|
              if side_menu_quarters.include?(q)
                "table.cell(fill: black, link(<#{q.id}>, text(white)[#{i18n.t('calendar.one_letter.quarter')}#{q.number}]))"
              else
                "link(<#{q.id}>, [#{i18n.t('calendar.one_letter.quarter')}#{q.number}])"
              end
            end

            months = params.months.map do |m|
              if side_menu_months.include?(m)
                "table.cell(fill: black, link(label(\"#{m.id}\"), text(white)[#{i18n.t("calendar.short.month.#{m.name.downcase}")}]))"
              else
                "link(label(\"#{m.id}\"), [#{i18n.t("calendar.short.month.#{m.name.downcase}")}])"
              end
            end

            if mosnav[:reverse_array_internals]
              quarters.reverse!
              months.reverse!
            end

            return "#{quarters.join(', ')}, [], #{months.join(', ')}" unless mosnav[:reverse_arrays]

            "#{months.join(', ')}, [], #{quarters.join(', ')}"
          end

          def menu_items
            items = []

            if params.planner_config.sections.find { |section| section.name == :annual }.enabled?
              first = top_menu_month

              if first
                page_number = annual_page_number(first)
                items << "link(label(\"annual-#{page_number}\"), [#{i18n.t('menu_calendar')}])"
              else
                items << if highlight_calendar?
                  "table.cell(fill: black, link(<annual-1>, text(white)[#{i18n.t('menu_calendar')}]))"
                else
                  "link(<annual-1>, [#{i18n.t('menu_calendar')}])"
                end
              end
            end

            <<~TYPST
              table(
                  stroke: (x, y) => (left: 0.4pt, right: 0.4pt),
                  columns: #{items.size},
                  rows: 1fr,
                  align: horizon + center,
                  #{items.join(', ')}
                )
            TYPST
          end

          def heading_columns
            "#{mosnav[:width]}, 1fr"
          end

          def mosnav
            params.object(:mos_nav)
          end

          def heading
            params.object(:heading)
          end
        end
      end
    end
  end
end
