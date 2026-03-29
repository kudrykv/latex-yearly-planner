# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class DailySchedule
          attr_accessor :i18n, :from, :to, :trailing_30_minutes, :time_format

          def initialize(i18n:, from:, to:, trailing_30_minutes:, time_format:, **_rest)
            self.i18n = i18n
            self.from = from
            self.to = to
            self.trailing_30_minutes = trailing_30_minutes
            self.time_format = time_format
          end

          def generate
            <<~TYPST.strip
              grid(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, y) =>
                  if calc.even(y) { ( bottom: regular_stroke + black ) }
                  else { ( bottom: regular_stroke + gray ) },
                grid.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t("schedule")}]))),
                #{schedule_lines},

                #{"box(height: 5mm)" if trailing_30_minutes}
              )
            TYPST
          end

          private

          def schedule_lines
            (from..to).map do |hour|
              "box(height: 5mm, align(horizon, [#{pretty_hour(hour:)}])), box(height: 5mm)"
            end.join(",\n")
          end

          def pretty_hour(hour:)
            Time.new(1, 1, 1, hour, 0, 0).strftime(time_format)
          end
        end
      end
    end
  end
end
