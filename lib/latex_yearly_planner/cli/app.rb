# frozen_string_literal: true

module LatexYearlyPlanner
  module CLI
    class App < Thor
      def self.exit_on_failure?
        true
      end

      desc 'generate', 'Generate a yearly planner'
      def generate(path_to_yaml_file)
        result = HighLevel::Planner::Generate.call(path_to_yaml_file:)
        raise result.error if result.failure?

        puts 'Generated'
      end
    end
  end
end
