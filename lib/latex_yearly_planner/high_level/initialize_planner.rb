# frozen_string_literal: true

module LatexYearlyPlanner
  module HighLevel
    class InitializePlanner
      include Interactor

      def call
        context.planner = Core::Planner.new(generator:, writer:, compiler:)
      end

      private

      def generator
        context.generator
      end

      def writer
        context.text_documents_writer
      end

      def compiler
        context.compiler
      end
    end
  end
end
