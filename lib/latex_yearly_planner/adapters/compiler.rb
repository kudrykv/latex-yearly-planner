# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Compiler
      def initialize(params, file_path)
        @params = params || RecursiveOpenStruct.new
        @file_path = file_path
      end

      def compile(index_file)
        number = params.runs || 1

        number.times do
          `cd #{file_path} && pdflatex -halt-on-error #{index_file}`
        end

        raise "Error compiling #{index_file}" unless $?.success?
      end

      private

      attr_reader :params, :file_path
    end
  end
end
