# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyBody < Component
          def generate(day)
            TeX::Minipage.new(
              content: "#{schedule}\n#{little_calendar(day.month)}",
              width: '0.5\linewidth',
            )
          end

          private

          def schedule
            XTeX::Schedule.new(**schedule_options)
          end

          def little_calendar(month)
            XTeX::CalendarLittle.new(month, **config.little_calendar(section_name))
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
