# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeTypstCompiler
      include Interactor

      def call
        context.typst_compiler = Adapters::TypstCompiler.new(workdir:, planner_config:)
      end

      private

      def workdir
        raise DevelopmentError, 'workdir is not defined' unless context.workdir

        context.workdir
      end

      def planner_config
        raise DevelopmentError, 'planner_config is not defined' unless context.planner_config

        context.planner_config
      end
    end
  end
end
