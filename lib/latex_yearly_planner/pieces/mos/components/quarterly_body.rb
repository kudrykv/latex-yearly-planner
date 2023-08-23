# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyBody < Component
          def generate(quarter)
            ["\\fbox{#{calendars_minipage(quarter)}}", spacer, "\\fbox{#{notes}}"].join('')
          end

          private

          def calendars_minipage(quarter)
            TeX::Minipage.new(
              content: "\\vspace{0pt}#{calendars_vertical(quarter)}",
              height: '\\remainingHeight',
              width: param(:calendars_width),
            )
          end

          def calendars_vertical(quarter)
            quarter
              .months
              .map { |month| XTeX::CalendarLittle.new(month, **config.little_calendar(section_name)) }
              .join("\n\\vfill{}")
          end

          def spacer
            "\\hspace{#{param(:spacer_width)}}"
          end

          def notes
            TeX::Minipage.new(
              content: "\\vspace{0pt}#{XTeX::Notes.new(notes_type, **notes_parameters)}",
              height: '\\remainingHeight',
              width: param(:notes_width)
            )
          end

          def notes_type
            section_config.parameters&.notes&.type || config.parameters.parameters&.notes&.type
          end

          def notes_parameters
            section_config.parameters&.notes&.parameters_as_a_hash ||
              config.parameters.parameters&.notes&.parameters_as_a_hash ||
              {}
          end
        end
      end
    end
  end
end
