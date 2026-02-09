# frozen_string_literal: true

module LatexYearlyPlanner
  module Services
    class Generator
      attr_reader :indexer, :sectioner

      def initialize(indexer:, sectioner:)
        @indexer = indexer
        @sectioner = sectioner
      end

      def generate
        indexer.index(text_documents)
      end

      private

      def text_documents
        sectioner.sections.select(&:enabled?).map(&:generate)
      end
    end
  end
end
