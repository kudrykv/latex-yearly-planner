# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexTodosBody < Component
          def generate_index(page)
            XTeX::IndexTable.new(**struct(:index_table).deep_merge(additional_index_params(page)))
          end

          def generate_todo(_todo, _page)
            [
              minipage_with_todos,
              hfill,
              minipage_with_todos
            ].join
          end

          private

          def minipage_with_todos
            TeX::Minipage.new(
              content: XTeX::ToDo.new(**struct(:todos)),
              width: param(:column_width)
            )
          end

          def additional_index_params(page)
            { parameters: { start_from: start_from(page) } }
          end

          def start_from(page)
            ((page - 1) * param(:todos_per_page)) + 1
          end
        end
      end
    end
  end
end
