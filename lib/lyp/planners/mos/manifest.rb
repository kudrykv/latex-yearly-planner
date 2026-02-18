# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Manifest
        attr_accessor :sections, :sources

        def initialize
          self.sources = Set.new
          self.sections = Set.new
        end

        def register_source(id) = sources.add(id)

        def source?(id) = sources.member?(id)

        def register_section(name) = sections.add(name)
      end
    end
  end
end
