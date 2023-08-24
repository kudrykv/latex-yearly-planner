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
            quarter
              .months
              .map { |month| XTeX::CalendarLittle.new(month, **config.little_calendar(section_name)) }
              .join("\n\\vfill{}")
          end

          def spacer
            "\\hspace{#{param(:spacer_width)}}"
          end

          def notes
            XTeX::Notes.new(notes_type, **notes_parameters)
          end

          def notes_type
            param(:notes, :type)
          end

          def notes_parameters
            { compensate_height: '0pt' }
              .merge(param(:notes).parameters_as_a_hash || {})
          end

          def minipage_height
            param(:notes, :parameters, :height)
          end

          def minipage_width
            param(:notes, :parameters, :width)
          end
        end
      end
    end
  end
end
