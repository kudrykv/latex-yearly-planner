# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexTodosHeader < Header
          def generate_index(page)
            [
              top_table,
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
              top_table,
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

          def index_title(_page)
            TeX::TextSize.new('Index').huge
          end

          def todo_title(todo)
            TeX::TextSize.new("To Do #{todo}").huge
          end
        end
      end
    end
  end
end
