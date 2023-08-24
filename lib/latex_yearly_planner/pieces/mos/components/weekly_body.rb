# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class WeeklyBody < Component
          def generate(week)
            [
              week.days.take(3).map { |day| col(day.name) }.join('\\hfill{}'),
              week.days.drop(3).take(3).map { |day| col(day.name) }.join('\\hfill{}'),
              [col(week.days.last.name), col('Notes'), col(XTeX::Dummy.new)].join('\\hfill{}')
            ].join('\\vfill{}')
          end

          private

          def col(content)
            TeX::Parbox.new(content:, width: column_width)
          end

          def column_width
            param(:column_width)
          end
        end
      end
    end
  end
end
