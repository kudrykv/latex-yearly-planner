# frozen_string_literal: true

require 'yaml'

module LatexYearlyPlanner
  module CLI
    class App < Thor
      desc 'generate', 'Generate a LaTeX yearly planner'
      def generate(yaml_config)
        yaml_file = YAML.load_file(yaml_config)

        generator = LatexYearlyPlanner::Core::Planners::Generator.new(nil, [])
        planner = LatexYearlyPlanner::Core::Planners::Planner.new(generator)

        planner.generate
        planner.write
        planner.compile
      end
    end
  end
end
