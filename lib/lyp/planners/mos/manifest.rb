# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Manifest
          attr_accessor :sources

          def initialize
            self.sources = Set.new
          end

          def register_source(id)
            sources.add(id)
          end
        end
      end
    end
  end
end
