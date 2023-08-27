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
              TeX::Minipage.new(
                content: XTeX::ToDo.new(**parameters(:todos)),
                width: param(:column_width),
              ),
              hfill,
              TeX::Minipage.new(
                content: XTeX::ToDo.new(**parameters(:todos)),
                width: param(:column_width),
              ),
            ].join
          end

          def additional_index_params(page)
            { parameters: { start_from: start_from(page), count: param(:todos_per_page) } }
          end

          def start_from(page)
            ((page - 1) * param(:todos_per_page)) + 1
          end
        end
      end
    end
  end
end
