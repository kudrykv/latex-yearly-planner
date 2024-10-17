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
                table(
                  columns: 2,
                  rows: 1fr,
                  align: horizon + center,
                  #{menu_items}
                )
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
                  columns: (#{(['1fr'] * 4).join(', ')}, auto, #{(['1fr'] * 12).join(', ')}),
                  rows: 1fr,
                  align: horizon + center,
                  #{side_menu_content}
                  )]
                )
            TYPST
          end

          def side_menu_content
            quarters = params.quarters.map { |q| "[#{i18n.t('calendar.one_letter.quarter')}#{q.number}]" }
            months = params.months.map { |m| "[#{i18n.t("calendar.short.month.#{m.name.downcase}")}]" }

            if mosnav[:reverse_array_internals]
              quarters.reverse!
              months.reverse!
            end

            return "#{quarters.join(', ')}, [], #{months.join(', ')}" unless mosnav[:reverse_arrays]

            "#{months.join(', ')}, [], #{quarters.join(', ')}"
          end

          def menu_items(...)
            ['[Calendar]', '[Notes]'].join(', ')
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
