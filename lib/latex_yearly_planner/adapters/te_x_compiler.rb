# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class TeXCompiler
      attr_reader :workdir

      def initialize(workdir:)
        @workdir = workdir
      end

      def compile(text_document)
        `cd #{workdir} && xelatex #{text_document.name}`
      end
    end
  end
end
