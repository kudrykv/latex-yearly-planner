# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Pages
        class Daily
          attr_accessor :i18n, :manifest, :day, :debug, :params

          def initialize(i18n:, manifest:, day:, debug: false, **params)
            self.i18n = i18n
            self.manifest = manifest
            self.day = day
            self.debug = debug
            self.params = params
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
            <<~TYPST
              grid(
                columns: (auto, auto),
                rows: 1fr,
                [#{left_column}]
              )
            TYPST
          end

          private

          def left_column
            params[:left_column].map do |comp|
              next unless comp[:enabled]

              case comp[:class]
              when "schedule"
                my_schedule(**comp[:params])
              end
            end.join
          end

          def my_schedule(from:, to:, strftime:, trailing_30_minutes:)
            <<~TYPST
              #grid(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, y) =>
                  if calc.even(y) { ( bottom: 0.4pt + black ) }
                  else { ( bottom: 0.4pt + gray ) },
                grid.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t('schedule')}]))),
                #{schedule_lines(from:, to:, strftime:)},
                #{trailing_30_minutes ? 'box(height: 5mm)' : ''}
              )
            TYPST
          end

          def schedule_lines(from:, to:, strftime:)
            (from..to).map do |hour|
              "box(height: 5mm, align(horizon, [#{pretty_hour(hour:, strftime:)}])), box(height: 5mm)"
            end.join(",\n")
          end

          def pretty_hour(hour:, strftime:)
            DateTime.parse("#{hour}:00").strftime(strftime)
          end
        end
      end
    end
  end
end
