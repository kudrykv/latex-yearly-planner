# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class WeeklyBody < Component
          def generate(week)
            [
              week.days.take(3).map { |day| cell(day) }.join('\\hfill{}'),
              week.days.drop(3).take(3).map { |day| cell(day) }.join('\\hfill{}'),
              cell(week.days.last)
            ].join('\\vfill{}')
          end

          private

          def cell(day)
            "\\fbox{#{TeX::Minipage.new(
              content: day.name,
              width: param(:cell, :width),
              height: param(:cell, :height)
            )}}"
          end
        end
      end
    end
  end
end
