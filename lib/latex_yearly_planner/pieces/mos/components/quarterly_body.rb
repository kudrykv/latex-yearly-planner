# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class QuarterlyBody < Component
          def generate(quarter)
            "#{calendars_minipage(quarter)}\\leaders hello"
          end

          private

          def calendars_minipage(quarter)
            TeX::Minipage.new(
              content: calendars_vertical(quarter),
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
        end
      end
    end
  end
end
