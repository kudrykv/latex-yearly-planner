# frozen_string_literal: true

require 'English'
module LatexYearlyPlanner
  module Adapters
    class TeXCompiler
      attr_reader :workdir

      def initialize(workdir:)
        @workdir = workdir
      end

      def compile(text_document)
        `cd #{workdir} && xelatex -halt-on-error #{text_document.name}`
        raise "Error compiling #{text_document.name}" unless $CHILD_STATUS.success?
      end
    end
  end
end
