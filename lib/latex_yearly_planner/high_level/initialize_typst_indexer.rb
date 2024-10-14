module LatexYearlyPlanner
  module HighLevel
    class InitializeTypstIndexer
      include Interactor

      def call
        context.typst_indexer = Adapters::TypstIndexer.new(planner_config:)
      end

      private

      def planner_config
        raise DevelopmentError, '`planner_config` is not defined' unless context.planner_config

        context.planner_config
      end
    end
  end
end