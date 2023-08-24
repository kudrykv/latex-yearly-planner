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
              row([week.days.last.name, 'Notes', XTeX::Dummy.new]),
            ].join('\\vfill{}')
          end

          private

          def row(arr)
            names = arr.map { |content| col(content) }.join('\\hfill{}')
            minipage = TeX::Minipage.new(
              content: XTeX::Notes.new(notes_type, width: notes_width, height: notes_height),
              width: notes_width,
              height: notes_height,
              compensate_height: '0pt'
            )

            "#{names}\n#{minipage}".strip
          end

          def col(content)
            TeX::Parbox.new(content:, width: column_width)
          end

          def column_width
            param(:column_width)
          end

          def notes_type
            param(:notes, :type)
          end

          def notes_width
            param(:notes, :parameters, :width)
          end

          def notes_height
            param(:notes, :parameters, :height)
          end
        end
      end
    end
  end
end
