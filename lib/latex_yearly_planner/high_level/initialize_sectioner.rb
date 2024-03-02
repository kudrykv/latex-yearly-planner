# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeSectioner
      include Interactor

      def call
        context.sectioner = Adapters::Sectioner.new(planner_config:)
      end

      private

      def planner_config
        raise DevelopmentError, '`planner_config` is not defined' unless context.planner_config

        context.planner_config
      end
    end
  end
end
