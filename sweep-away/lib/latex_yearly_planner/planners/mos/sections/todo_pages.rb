# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    module Mos
      module Sections
        class TodoPages < Section
          def pages
            (1..todo_pages)
          end

          private

          def todo_pages
            index_pages = index_params.get(:pages)
            columns = index_params.get(:columns)
            rows = index_params.get(:rows)

            columns * rows * index_pages
          end

          def index_params
            @index_params ||= params.section!(:todo_index).params
          end
        end
      end
    end
  end
end
