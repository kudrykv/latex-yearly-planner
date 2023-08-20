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
          hash = { index: nil, sections: [] }

          sections.select(&:enabled?).each { |section| hash[:sections] << section }

          hash[:index] = indexer.generate(hash[:sections])

          hash
        end

        private

        attr_reader :indexer, :sections
      end
    end
  end
end
