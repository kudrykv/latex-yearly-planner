# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Sections
        class IndexNotes < Section
          def generate
            pages = index_pages

            header.index_notes_disable_highlight = true

            pages << notes_pages

            contents = "#{pages.join("\n\\pagebreak{}\n\n")}\n\\pagebreak{}"
            Core::Entities::Note.new('index_notes', contents)
          end

          private

          def index_pages
            param(:index_pages).times.map(&:succ).map do |page|
              "#{header.generate_index(page)}#{body.generate_index(page)}"
            end
          end

          def notes_pages
            (param(:index_pages) * param(:notes_per_page)).times.map(&:succ).map do |note|
              param(:pages_per_note).times.map(&:succ).map do |page|
                "#{header.generate_notes(note, page)}#{body.generate_notes(note, page)}"
              end
            end
          end
        end
      end
    end
  end
end
