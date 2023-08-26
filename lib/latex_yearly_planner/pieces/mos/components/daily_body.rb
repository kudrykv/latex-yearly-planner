# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyBody < Component
          def generate(day)
            [
              schedule_column(day),
              spacer,
              writings_column
            ].join
          end

          private

          def schedule_column(day)
            TeX::Minipage.new(
              content: [schedule, little_calendar(day)].join("\n"),
              width: param(:schedule_column_width)
            )
          end

          def writings_column
            TeX::Minipage.new(
              content: [
                XTeX::ToDo.new(**parameters(:todo)),
                nl,
                XTeX::Notes.new(param(:notes, :type), **parameters(:notes))
              ].join,
              width: param(:write_column_width)
            )
          end

          def schedule
            XTeX::Schedule.new(**parameters(:schedule))
          end

          def little_calendar(day)
            XTeX::CalendarLittle.new(
              day.month,
              **parameters(:little_calendar).merge({ highlight_day: day })
            )
          end

          def spacer
            "\\hspace{#{param(:spacer_width)}}"
          end

          def write_column_width
            param(:write_column_width)
          end
        end
      end
    end
  end
end
