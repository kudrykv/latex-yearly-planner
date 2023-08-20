# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Compiler
      def initialize(file_path)
        @file_path = file_path
      end

      def compile(index_file)
        `cd #{file_path} && pdflatex -halt-on-error #{index_file}`
      end

      private

      attr_reader :file_path
    end
  end
end
