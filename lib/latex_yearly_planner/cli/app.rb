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
      option :generated_files_output_path,
             type: :string,
             aliases: '-o',
             desc: 'Generated files output path',
             default: './out'

      def generate(path_to_yaml_file)
        result = HighLevel::Planner::Generate.call(path_to_yaml_file:, **options)
        raise result.error if result.failure?

        puts 'Generated'
      end
    end
  end
end
