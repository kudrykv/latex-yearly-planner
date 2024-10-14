# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeGenerator
      include Interactor

      def call
        context.generator = Core::Generator.new(indexer:, sectioner:)
      end

      private

      def indexer
        raise DevelopmentError, '`indexer` is not defined' unless context.indexer

        context.typst_indexer
      end

      def sectioner
        raise DevelopmentError, '`sectioner` is not defined' unless context.sectioner

        context.sectioner
      end
    end
  end
end
