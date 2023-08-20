# frozen_string_literal: true

module LatexYearlyPlanner
  module CLI
    class App < Thor
      desc 'generate', 'Generate a LaTeX yearly planner'
      method_option :out, type: :string, default: './out'
      def generate(yaml_config)
        hash = YAML.load_file(yaml_config)
        config = RecursiveOpenStruct.new(hash, recurse_over_arrays: true)

        indexer = LatexYearlyPlanner::Adapters::Indexer.new(config)
        sections = LatexYearlyPlanner::Adapters::Sectioner.new(config).sections

        generator = LatexYearlyPlanner::Core::Planners::Generator.new(indexer, sections)
        writer = LatexYearlyPlanner::Adapters::FileWriter.new(options[:out])

        planner = LatexYearlyPlanner::Core::Planners::Planner.new(generator, writer)

        planner.generate
        planner.write
        planner.compile
      end
    end
  end
end
