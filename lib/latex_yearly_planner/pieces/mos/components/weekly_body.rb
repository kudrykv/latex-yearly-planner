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
            ].join('\\vfill{}')
          end

          private

          def row(arr)
            names = arr.map { |content| col(content) }.join('\\hfill{}')
            notes = XTeX::Notes.new(notes_type, **notes_parameters)

            "#{names}\n#{notes}".strip
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

          def notes_parameters
            param(:notes).parameters_as_a_hash
          end
        end
      end
    end
  end
end
