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
      option :workdir,
             type: :string,
             aliases: '-w',
             desc: 'Working directory, where generation and compilation will be done',
             default: './out'

      def generate(path_to_yaml_file)
        HighLevel::Planner::Generate.call(path_to_yaml_file:, **options)

        puts 'Generated'
      end
    end
  end
end
