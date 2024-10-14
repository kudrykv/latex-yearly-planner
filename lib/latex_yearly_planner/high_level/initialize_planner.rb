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
        raise DevelopmentError, '`generator` is not defined' unless context.generator

        context.generator
      end

      def writer
        raise DevelopmentError, '`text_documents_writer` is not defined' unless context.text_documents_writer

        context.text_documents_writer
      end

      def compiler
        raise DevelopmentError, '`compiler` is not defined' unless context.compiler

        context.compiler
      end
    end
  end
end
