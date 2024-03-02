# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class IndexTodos < Section
          def generate
            pages = index_pages

            header.index_todos_disable_highlight = true

            pages << todos_pages

            contents = "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}"
            Core::Entities::Note.new('index_todos', contents)
          end

          private

          def index_pages
            param(:index_pages).times.map(&:succ).map do |page|
              "#{header.generate_index(page)}#{body.generate_index(page)}"
            end
          end

          def todos_pages
            (param(:index_pages) * param(:todos_per_page)).times.map(&:succ).map do |todo|
              param(:pages_per_todo).times.map(&:succ).map do |page|
                "#{header.generate_todo(todo, page)}#{body.generate_todo(todo, page)}"
              end
            end
          end
        end
      end
    end
  end
end
