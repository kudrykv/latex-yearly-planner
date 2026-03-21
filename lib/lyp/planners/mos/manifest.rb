# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Manifest
        def initialize
          self.sources = Set.new
          self.sections = Set.new
        end

        def register_source(id) = sources.add(id)

        def source?(id) = sources.member?(id)

        def register_section(name) = sections.add(name)

        private

        attr_accessor :sections, :sources
      end
    end
  end
end
