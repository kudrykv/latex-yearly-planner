# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class DailySchedule
          attr_accessor :i18n, :from, :to, :trailing_30_minutes, :strftime

          def initialize(i18n:, from:, to:, trailing_30_minutes:, strftime:)
            self.i18n = i18n
            self.from = from
            self.to = to
            self.trailing_30_minutes = trailing_30_minutes
            self.strftime = strftime
          end

          def generate
            <<~TYPST
              grid(
                columns: 1fr,
                inset: 0mm,
                stroke: (_, y) =>
                  if calc.even(y) { ( bottom: 0.4pt + black ) }
                  else { ( bottom: 0.4pt + gray ) },
                grid.cell(stroke: (bottom: 1pt), box(height: 5mm, align(horizon, [#{i18n.t('schedule')}]))),
                #{schedule_lines(from:, to:, strftime:)},

                #{"box(height: 5mm)" if trailing_30_minutes}
              )
            TYPST
          end

          private

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
