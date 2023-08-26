# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class WeeklyBody < Component
          def generate(week)
            [
              row(week.days.take(3).map(&:name)),
              row(week.days.drop(3).take(3).map(&:name)),
              row([week.days.last.name, 'Notes', XTeX::Dummy.new])
            ].join(vfill)
          end

          private

          def row(arr)
            names = arr.map(&method(:col)).join('\\hfill{}')
            notes = XTeX::Notes.new(param(:notes, :type), **parameters(:notes))

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
