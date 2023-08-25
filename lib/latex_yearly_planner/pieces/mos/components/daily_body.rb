# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyBody < Component
          def generate(day)
            XTeX::CalendarLittle.new(day.month, **config.little_calendar(section_name))
          end

          private

          def schedule
            XTeX::Schedule.new(**schedule_options)
          end

          def schedule_options
            {
              compensate_height: config.document.document_class.size
            }.merge(param(:schedule).parameters_as_a_hash)
          end
        end
      end
    end
  end
end
