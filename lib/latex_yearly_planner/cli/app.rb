# frozen_string_literal: true

require 'yaml'
require 'recursive-open-struct'
require 'active_support/all'

module LatexYearlyPlanner
  module CLI
    class App < Thor
      desc 'generate', 'Generate a LaTeX yearly planner'
      def generate(yaml_config)
        hash = YAML.load_file(yaml_config)
        config = RecursiveOpenStruct.new(hash, recurse_over_arrays: true)

        indexer = LatexYearlyPlanner::Adapters::Indexer.new(config)
        sections = LatexYearlyPlanner::Adapters::Sectioner.new(config).sections

        generator = LatexYearlyPlanner::Core::Planners::Generator.new(indexer, sections)
        planner = LatexYearlyPlanner::Core::Planners::Planner.new(generator)

        planner.generate
        planner.write
        planner.compile
      end
    end
  end
end
