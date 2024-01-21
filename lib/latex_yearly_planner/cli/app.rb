# frozen_string_literal: true

module LatexYearlyPlanner
  module CLI
    class App < Thor
      desc 'generate', 'Generate a LaTeX yearly planner'
      method_option :out, type: :string, default: './out'
      def generate(yaml_file_path)
        hash = YAML.load_file(yaml_file_path)
        config = LatexYearlyPlanner::Adapters::Config.new(hash)

        planner = make_planner(config.template)

        planner.generate
        planner.write
        planner.compile
      end

      private

      def make_planner(config)
        indexer = LatexYearlyPlanner::Adapters::Indexer.new(config)
        sections = LatexYearlyPlanner::Adapters::Sectioner.new(config).sections

        generator = LatexYearlyPlanner::Core::Planners::Generator.new(indexer, sections)
        writer = LatexYearlyPlanner::Adapters::FileWriter.new(options[:out])
        compiler = LatexYearlyPlanner::Adapters::Compiler.new(config.parameters.compile, options[:out])

        LatexYearlyPlanner::Core::Planners::Planner.new(generator, writer, compiler)
      end
    end
  end
end
