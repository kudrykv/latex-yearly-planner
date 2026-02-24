# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      module Components
        class DailyNotes
          attr_accessor :i18n

          def initialize(i18n:, **_rest)
            self.i18n = i18n
          end

          def generate
            <<~TYPST.strip
              text[hello world]
            TYPST
          end
        end
      end
    end
  end
end
