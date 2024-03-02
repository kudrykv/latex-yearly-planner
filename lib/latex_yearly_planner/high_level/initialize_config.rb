# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializeConfig
      include Interactor

      def call
        context.planner_config = Adapters::PlannerConfig.new(hash)
      end

      private

      def hash
        YAML.load_file(path_to_yaml_file)
      end

      def path_to_yaml_file
        raise DevelopmentError, '`path_to_yaml_file` is not defined' unless context.path_to_yaml_file

        context.path_to_yaml_file
      end
    end
  end
end
