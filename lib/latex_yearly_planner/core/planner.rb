# frozen_string_literal: true

module LatexYearlyPlanner
  module Core
    class Planner
      attr_accessor :generator, :writer, :compiler

      def create
        writer.write(file_tree)

        compiler.compile(writer.entry_file)
      end

      private

      def file_tree
        generator.generate
      end
    end
  end
end
