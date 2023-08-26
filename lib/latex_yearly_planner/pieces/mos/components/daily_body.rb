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
              content: [schedule_label, schedule, little_calendar(day)].join(nl),
              width: param(:schedule_column_width)
            )
          end

          def schedule_label
            XTeX::Label.new(**param(:schedule_label_as_a_hash))
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

          def writings_column
            TeX::Minipage.new(
              content: [
                todo_label, todo,
                nl,
                notes_label, notes,
                nl,
                personal_notes_label, personal_notes
              ].join(nl),
              width: param(:write_column_width)
            )
          end

          def todo_label
            XTeX::Label.new(**struct(:todo_label).deep_merge({ parameters: { text: 'To Do' } }))
          end

          def todo
            XTeX::ToDo.new(**parameters(:todo))
          end

          def notes_label
            XTeX::Label.new(**struct(:notes_label).deep_merge({ parameters: { text: 'Notes' } }))
          end

          def notes
            XTeX::Notes.new(param(:notes, :type), **parameters(:notes))
          end

          def personal_notes_label
            XTeX::Label.new(**struct(:personal_notes_label).deep_merge({ parameters: { text: 'Personal Notes' } }))
          end

          def personal_notes
            XTeX::Notes.new(param(:notes, :type), **parameters(:personal_notes))
          end

          def spacer
            hspace(param(:spacer_width))
          end

          def write_column_width
            param(:write_column_width)
          end
        end
      end
    end
  end
end
