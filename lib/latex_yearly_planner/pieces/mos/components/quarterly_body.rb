# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyBody < Component
          def generate(quarter)
            elements = [calendars_minipage(quarter), spacer, notes]
            elements = elements.reverse if param(:calendars_column_position).to_sym == :right

            elements.join
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
            XTeX::CalendarLittle.new(month, **struct(:little_calendar))
          end

          def spacer
            hspace(param(:spacer_width))
          end

          def notes
            XTeX::Notes.new(**struct(:notes))
          end
        end
      end
    end
  end
end
