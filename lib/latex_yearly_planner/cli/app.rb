# frozen_string_literal: true

module LatexYearlyPlanner
  module CLI
    class App < Thor
      def self.exit_on_failure?
        true
      end

      desc 'generate', 'Generate a yearly planner'
      option :locales_file_pattern,
             type: :string,
             aliases: '-l',
             desc: 'Locales file pattern',
             default: 'locales/*.yaml'
      def generate(path_to_yaml_file)
        result = HighLevel::Planner::Generate.call(path_to_yaml_file:, locales_file_pattern:)
        raise result.error if result.failure?

        puts 'Generated'
      end

      private

      def locales_file_pattern
        options[:locales_file_pattern]
      end
    end
  end
end
