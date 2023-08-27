# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      module Components
        class IndexNotesBody < Component
          def generate_index(page)
            'body index'
          end

          def generate_notes(page)
            'body notes'
          end
        end
      end
    end
  end
end
