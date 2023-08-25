# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class DailyBody < Component
          def generate(day)
            XTeX::Schedule.new(**schedule_options)
          end

          private

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
