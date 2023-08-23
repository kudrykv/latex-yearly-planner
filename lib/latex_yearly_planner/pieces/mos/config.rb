# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      class Config
        attr_reader :struct

        def initialize(struct)
          @struct = struct
        end

        def respond_to_missing?(...)
          struct.respond_to?(...)
        end

        def method_missing(...)
          struct.method_missing(...)
        end
      end
    end
  end
end
