# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
      module Pages
        class Annual < Face
          attr_reader :month_rows

          def set(month_rows)
            @month_rows = month_rows

            self
          end

          def title
            <<~TYPST
              text(#{heading_size})[
                #{first_month_name} #{first_year} ---
                #{last_month_name} #{last_year}
                <annual-#{page_number}>
              ]
            TYPST
          end

          def content
            "vert_stack_bottom_outset(#{month_rows.map { |row| row_stack(row) }.append('[]').join(', ')})"
          end

          def highlight_calendar?
            true
          end

          private

          def heading_size
            params.get(:heading_size)
          end

          def first_month_name
            i18n.t("calendar.short.month.#{month_rows.first.first.name.downcase}")
          end

          def first_year
            month_rows.first.first.year
          end

          def last_month_name
            i18n.t("calendar.short.month.#{month_rows.last.last.name.downcase}")
          end

          def last_year
            month_rows.last.last.year
          end

          def page_number
            (params.months.find_index(month_rows.first.first) / params.get(:months_per_page)) + 1
          end

          def row_stack(months)
            "stack(dir: ltr, spacing: 1fr, #{months_row(months)})"
          end

          def months_row(months)
            months
              .map { |month| Xtypst::LittleCalendar.new(month, **params.object(:little_calendar)).to_typst }
              .join(', ')
          end
        end
      end
    end
  end
end
