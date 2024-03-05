# frozen_string_literal: true

module LatexYearlyPlanner
  module Core
    class Planner
      attr_reader :generator, :writer, :compiler

      def initialize(generator:, writer:, compiler:)
        @generator = generator
        @writer = writer
        @compiler = compiler
      end

      def create
        writer.write(text_documents)

        compiler.compile(text_documents.first)
      end

      private

      def text_documents
        @text_documents ||= generator.generate
      end
    end
  end
end
