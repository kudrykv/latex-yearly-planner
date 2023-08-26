# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyBody < Component
          def generate(quarter)
            [calendars_minipage(quarter), spacer, notes].join
          end

          private

          def calendars_minipage(quarter)
            TeX::Minipage.new(
              content: calendars_vertical(quarter),
              height: '\\remainingHeight',
              width: param(:calendars_width)
            )
          end

          def calendars_vertical(quarter)
            quarter.months.map(&method(:little_calendar)).join("#{nl}#{vfill}")
          end

          def little_calendar(month)
            XTeX::CalendarLittle.new(month, **parameters(:little_calendar))
          end

          def spacer
            hspace(param(:spacer_width))
          end

          def notes
            XTeX::Notes.new(notes_type, **parameters(:notes))
          end

          def notes_type
            param(:notes, :type)
          end
        end
      end
    end
  end
end
