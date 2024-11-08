# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    module Plays
      class InitializePlannerConfig < Actor
        input :path_to_yaml_file, allow_nil: false
        output :planner_config

        def call
          self.planner_config = Adapters::PlannerConfig.new(hash)
        end

        private

        def hash
          YAML.load_file(path_to_yaml_file, symbolize_names: true)
        end
      end
    end
  end
end
