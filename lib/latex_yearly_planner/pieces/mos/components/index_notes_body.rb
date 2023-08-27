# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexNotesBody < Component
          def generate_index(page)
            XTeX::IndexTable.new(**struct(:index_table).deep_merge(additional_index_params(page)))
          end

          def generate_notes(_note, _page)
            XTeX::Notes.new(**struct(:notes))
          end

          private

          def additional_index_params(page)
            { parameters: { start_from: start_from(page), count: param(:notes_per_page) } }
          end

          def start_from(page)
            ((page - 1) * param(:notes_per_page)) + 1
          end
        end
      end
    end
  end
end
