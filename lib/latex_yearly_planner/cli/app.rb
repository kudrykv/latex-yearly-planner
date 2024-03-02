# frozen_string_literal: true

module LatexYearlyPlanner
  module CLI
    class App < Thor
      def self.exit_on_failure?
        true
      end

      desc 'generate', 'Generate a yearly planner'
      def generate
        puts 'Generating yearly planner'
      end
    end
  end
end
