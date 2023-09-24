# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexTodosHeader < Header
          def generate_index(page)
            [
              top_table(page:),
              hfill,
              index_title(page),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
          end

          def generate_todo(todo, _page)
            [
              top_table(todo:),
              hfill,
              todo_title(todo),
              hrule,
              margin_note,
              nl,
              vspace(param(:header, :skip)),
              nlnl
            ].join
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
