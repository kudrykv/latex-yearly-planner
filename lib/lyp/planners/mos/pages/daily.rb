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
                Components::DailySchedule.new(i18n:, **comp[:params]).generate
              end
            end.join
          end
        end
      end
    end
  end
end
