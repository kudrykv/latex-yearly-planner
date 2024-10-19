# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Annual < Face
          def title(month_rows)
            first = month_rows.first.first
            last = month_rows.last.last

            <<~TYPST
              text(#{params.get(:heading_size)})[#{i18n.t("calendar.short.month.#{first.name.downcase}")}
               #{first.year}
               ---
               #{i18n.t("calendar.short.month.#{last.name.downcase}")}
               #{last.year} <annual-#{page_number(first)}>
              ]
            TYPST
          end

          def content(month_rows)
            <<~TYPST
              vert_stack_bottom_outset(#{month_rows.map { |row| row_stack(row) }.append('[]').join(', ')})
            TYPST
          end

          def row_stack(months)
            <<~TYPST
              stack(
                dir: ltr,
                spacing: 1fr,
                #{months.map { |month| Xtypst::LittleCalendar.new(month, **params.object(:little_calendar)).to_typst }.join(', ')}
              )
            TYPST
          end

          def page_number(first_month)
            (params.months.find_index(first_month) / params.get(:months_per_page)) + 1
          end

          def highlight_calendar?
            true
          end
        end
      end
    end
  end
end
