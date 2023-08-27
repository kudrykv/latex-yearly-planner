# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class IndexNotes < Section
          def generate
            index_pages = param(:index_pages).times.map(&:succ).map do |page|
              "#{header.generate_index(page)}#{body.generate_index(page)}"
            end

            header.index_notes_disable_highlight = true

            notes_pages = param(:notes_pages).times.map(&:succ).map do |page|
              "#{header.generate_notes(page)}#{body.generate_notes(page)}"
            end

            contents = "#{index_pages.concat(notes_pages).join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}"
            Core::Entities::Note.new('index_notes', contents)
          end
        end
      end
    end
  end
end
