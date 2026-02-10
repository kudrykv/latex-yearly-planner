# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        module Sections
          class Weekly
            attr_accessor :overseer

            def initialize(overseer:, **_rest)
              self.overseer = overseer
            end

            def generate
              "text"
            end
          end
        end
      end
    end
  end
end
