# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Pages
        class Quarterly < Face
          attr_reader :quarter

          def set(quarter)
            @quarter = quarter

            self
          end

          def title
            <<~TYPST
              text(#{params.get(:heading_size)})[
                #{i18n.t('calendar.one_letter.quarter')}#{quarter.number}
                <#{quarter.id}>
              ]
            TYPST
          end

          def content
            columns.reverse! if params.get(:reverse_columns)
            columns_content.reverse! if params.get(:reverse_columns)

            <<~TYPST
              grid(
                columns: (#{columns.join(', ')}),
                rows: 1fr,
                #{columns_content.join(',')}
              )
            TYPST
          end

          def highlight_side_menu_quarters
            [quarter]
          end

          def top_menu_month
            quarter.months.first
          end

          private

          def columns
            @columns ||= [params.get(:months_width), params.get(:gap_width), '1fr']
          end

          def columns_content
            @columns_content ||= ["vert_stack_bottom_outset(#{months})", '[]', "rect_pattern(#{params.get(:pattern)})"]
          end

          def months
            quarter.months.map(&method(:create_little_calendar)).join(', ')
          end

          def create_little_calendar(month)
            Xtypst::LittleCalendar.new(month, **params.object(:little_calendar)).to_typst
          end
        end
      end
    end
  end
end
