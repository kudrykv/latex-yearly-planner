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
              writings_column(day)
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
            XTeX::Label.new(**struct(:schedule_label).deep_merge({ parameters: { text: 'Schedule' } }))
          end

          def schedule
            XTeX::Schedule.new(**parameters(:schedule))
          end

          def little_calendar(day)
            XTeX::CalendarLittle.new(
              day.month,
              **struct(:little_calendar).deep_merge({ parameters: { highlight_day: day } })
            )
          end

          def writings_column(day)
            TeX::Minipage.new(
              content: [
                todo_label, todo,
                nl,
                notes_label(day), notes,
                nl,
                personal_notes_label(day), personal_notes
              ].join(nl),
              width: param(:write_column_width)
            )
          end

          def todo_label
            XTeX::Label.new(**struct(:todo_label).deep_merge({ parameters: { text: 'To Do' } }))
          end

          def todo
            XTeX::ToDo.new(**struct(:todo))
          end

          def notes_label(day)
            arr = ['Notes']
            arr.push(hfill, link_daily_notes('More', day:)) if config.sections.daily_notes.enabled
            text = arr.join

            XTeX::Label.new(**struct(:notes_label).deep_merge({ parameters: { text: } }))
          end

          def notes
            XTeX::Notes.new(**struct(:notes))
          end

          def personal_notes_label(day)
            arr = ['Personal Notes']
            arr.push(hfill, link_daily_notes('More', day:)) if config.sections.daily_reflect.enabled
            text = arr.join

            XTeX::Label.new(**struct(:personal_notes_label).deep_merge({ parameters: { text: } }))
          end

          def personal_notes
            XTeX::Notes.new(**struct(:personal_notes))
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
