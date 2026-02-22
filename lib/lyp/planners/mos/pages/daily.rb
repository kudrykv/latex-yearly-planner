# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Daily
          attr_accessor :i18n, :manifest, :day, :columns_width, :column_gutter, :params, :debug

          def initialize(i18n:, manifest:, day:, columns_width:, column_gutter:, debug: false, **params)
            self.i18n = i18n
            self.manifest = manifest
            self.day = day
            self.columns_width = columns_width
            self.column_gutter = column_gutter
            self.params = params
            self.debug = debug
          end

          def title
            <<~TYPST
              grid(
                columns: (auto, auto),
                rows: (3fr, 2fr),
                column-gutter: 4pt,
                #{"stroke: 0.4pt," if debug}

                grid.cell(
                  rowspan: 2,
                  align: center + horizon,
                  rect(
                    stroke: (right: 0.4pt),

                    text(size: 24pt)[#{day.month_day} <#{day.id}>]
                  )
                ),
                [*#{i18n.t("weekday.full.#{day.weekday_name}")}*],
                [#{i18n.t("months.full.#{day.month.name}")}]
              )
            TYPST
          end

          def content
            <<~TYPST.strip
              grid(
                columns: #{columns_width},
                rows: 1fr,
                column-gutter: #{column_gutter},
                [#{left_column}],
                [#{right_column}]
              )
            TYPST
          end

          private

          def left_column
            column(params[:left_column])
          end

          def right_column
            column(params[:right_column])
          end

          def column(comps)
            comps.map do |comp|
              next unless comp[:enabled]

              case comp[:class]
              when "schedule"
                "##{Components::DailySchedule.new(i18n:, **comp[:params]).generate}"
              when "top_priorities"
                "##{Components::DailyTopPriorities.new(i18n:, **comp[:params]).generate}"
              end
            end.join
          end
        end
      end
    end
  end
end
