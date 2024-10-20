# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module TypstMos
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
            QuarterlyContent.new(quarter:, section_config:, i18n:).to_typst
          end

          def highlight_side_menu_quarters
            [quarter]
          end

          def top_menu_month
            quarter.months.first
          end

          class QuarterlyContent < Base
            attr_reader :quarter

            def initialize(quarter:, section_config:, i18n:)
              super(section_config:, i18n:)

              @quarter = quarter
            end

            def to_typst
              <<~TYPST
                grid(
                  columns: (#{columns}),
                  rows: 1fr,
                  #{columns_content}
                )
              TYPST
            end

            private

            def columns
              cols = [params.get(:months_width), params.get(:gap_width), '1fr']

              cols.reverse! if params.get(:reverse_columns)

              cols.join(', ')
            end

            def columns_content
              cols = ["vert_stack_bottom_outset(#{months})", '[]', "rect_pattern(#{params.get(:pattern)})"]

              cols.reverse! if params.get(:reverse_columns)

              cols.join(', ')
            end

            def months
              quarter.months.map do |month|
                Xtypst::LittleCalendar.new(month, **params.object(:little_calendar)).to_typst
              end.join(', ')
            end
          end
        end
      end
    end
  end
end
