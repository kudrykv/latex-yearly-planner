# frozen_string_literal: true

module LatexYearlyPlanner
  module Core
    module Planners
      class Generator
        def initialize(indexer, sections)
          @indexer = indexer
          @sections = sections
        end

        def generate
          hash = { index: nil, notes: [] }

          sections.select(&:enabled?).each { |section| hash[:notes] << section.generate }

          hash[:index] = indexer.generate(hash[:notes])

          hash
        end

        private

        attr_reader :indexer, :sections
      end
    end
  end
end
