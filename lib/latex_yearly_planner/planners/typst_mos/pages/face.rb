# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Face < Page
          def generate(...)
            <<~TYPST
              #grid(
                columns: (#{mosnav[:width]}, 1fr),
                rows: (#{heading[:height]}, 1fr),
                grid.cell(
                  rowspan: 2,
                  pad(right: #{mosnav[:inset]}, #{side_menu_layout(...)})
                ),
                pad(bottom: #{heading[:inset]}, #{headerlike(...)}), #{content(...)}
              )
            TYPST
          end

          def headerlike(...)
            <<~TYPST
              table(
                columns: (auto, 1fr, auto),
                rows: 1fr,
                align: horizon + center,
                inset: 0mm,
                stroke: 0mm,
                #{title(...)},
                [],
                #{menu_items(...)}
              )
            TYPST
          end

          def title(...)
            raise NotImplementedError
          end

          def content(...)
            raise NotImplementedError
          end

          def side_menu_layout(...)
            <<~TYPST
              rotate(
                  #{mosnav[:rotate]},
                  origin: center + horizon,
                  reflow: true,
                  [
                  #table(
                  stroke: 0.4pt,
                  columns: (#{(['1fr'] * 4).join(', ')}, auto, #{(['1fr'] * 12).join(', ')}),
                  rows: 1fr,
                  align: horizon + center,
                  #{side_menu_content(...)}
                  )]
                )
            TYPST
          end

          def side_menu_content(...)
            quarters = params.quarters.map do |q|
              "link(label(\"Q#{q.year}-#{q.number}\"), [#{i18n.t('calendar.one_letter.quarter')}#{q.number}])"
            end
            months = params.months.map { |m| "[#{i18n.t("calendar.short.month.#{m.name.downcase}")}]" }

            if mosnav[:reverse_array_internals]
              quarters.reverse!
              months.reverse!
            end

            return "#{quarters.join(', ')}, [], #{months.join(', ')}" unless mosnav[:reverse_arrays]

            "#{months.join(', ')}, [], #{quarters.join(', ')}"
          end

          def menu_items(...)
            items = []

            if params.planner_config.sections.find { |section| section.name == :annual }.enabled?
              first = current_months(...).first

              if first
                page_number = annual_page_number(first)
                items << "link(label(\"annual-#{page_number}\"), [Calendar])"
              else
                items << if highlight_calendar?
                           'table.cell(fill: black, link(label("annual-1"), text(white)[Calendar]))'
                         else
                           'link(label("annual-1"), [Calendar])'
                         end
              end
            end

            <<~TYPST
              table(
                  stroke: 0.4pt,
                  columns: #{items.size},
                  rows: 1fr,
                  align: horizon + center,
                  #{items.join(', ')}
                )
            TYPST
          end

          def current_months(...)
            []
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
