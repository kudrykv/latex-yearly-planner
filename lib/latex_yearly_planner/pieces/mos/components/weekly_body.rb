# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class WeeklyBody < Component
          include XTeX::HyperHelpers

          def generate(week)
            [
              first_row(week),
              second_row(week),
              third_row(week)
            ].join(vfill)
          end

          private

          def first_row(week)
            row(week.days.take(3).map { |day| link_day(day.name, day:) })
          end

          def second_row(week)
            row(week.days.drop(3).take(3).map { |day| link_day(day.name, day:) })
          end

          def third_row(week)
            row([link_day(week.days.last.name, day: week.days.last), 'Notes', XTeX::Dummy.new])
          end

          def row(arr)
            names = arr.map(&method(:col)).join('\\hfill{}')
            notes = XTeX::Notes.new(**struct(:notes))

            "#{names}\n#{notes}".strip
          end

          def col(content)
            TeX::Parbox.new(content:, width: param(:column_width))
          end
        end
      end
    end
  end
end
