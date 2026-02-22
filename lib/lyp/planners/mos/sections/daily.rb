# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Sections
        class Daily
          attr_accessor :i18n, :overseer

          def initialize(i18n:, overseer:, **_rest)
            self.i18n = i18n
            self.overseer = overseer
          end

          def register(manifest)
            (overseer.start_date..overseer.end_date).each do |date|
              manifest.register_source(date.id)
            end
          end

          def generate(planner, _manifest)
            (overseer.start_date..overseer.end_date).each do |date|
              planner.add_page(title: title(date), content: '')
            end
          end

          private

          def title(date)
            <<~TYPST
              grid(
                columns: (auto, auto),
                rows: (3fr, 2fr),
                column-gutter: 4pt,
                #{"stroke: 0.4pt," if overseer.debug?}

                grid.cell(
                  rowspan: 2,
                  align: center + horizon,
                  rect(
                    stroke: (right: 0.4pt),

                    text(size: 24pt)[#{date.month_day} <#{date.id}>]
                  )
                ),
                [*#{i18n.t("weekday.full.#{date.weekday_name}")}*],
                [#{i18n.t("months.full.#{date.month.name}")}]
              )
            TYPST
          end
        end
      end
    end
  end
end
