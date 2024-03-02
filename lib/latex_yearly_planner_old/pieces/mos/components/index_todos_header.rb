# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexTodosHeader < Header
          def generate_index(page)
            make_header(top_table(page:), index_title(page))
          end

          def generate_todo(todo, _page)
            make_header(top_table(todo:), todo_title(todo))
          end

          private

          def index_title(page)
            content = TeX::TextSize.new('Index').huge
            target_reference(content, reference: TODOS_INDEX_REFERENCE, page:)
          end

          def todo_title(todo)
            content = TeX::TextSize.new("To Do #{todo}").huge
            target_todo(content, todo:)
          end
        end
      end
    end
  end
end
