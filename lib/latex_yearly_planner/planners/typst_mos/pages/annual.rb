# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Annual < Face
          def title(month_rows, _page_number)
            first = month_rows.first.first
            last = month_rows.last.last

            <<~TYPST
              [#{i18n.t("calendar.short.month.#{first.name.downcase}")}
               #{first.year}
               ---
               #{i18n.t("calendar.short.month.#{last.name.downcase}")}
               #{last.year}
              ]
            TYPST
          end

          def content(month_rows, _page_number)
            <<~TYPST
              stack(
                dir: ttb,
                spacing: 1fr,
                #{month_rows.map { |row| row_stack(row) }.append('[]').join(', ')}
              )
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
        end
      end
    end
  end
end
