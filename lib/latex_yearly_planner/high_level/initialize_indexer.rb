# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeIndexer
      include Interactor

      def call
        context.indexer = Adapters::Indexer.new(planner_config:)
      end

      private

      def planner_config
        raise DevelopmentError, '`planner_config` is not defined' unless context.planner_config

        context.planner_config
      end
    end
  end
end
