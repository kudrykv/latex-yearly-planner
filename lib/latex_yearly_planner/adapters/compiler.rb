# frozen_string_literal: true

require 'English'
module LatexYearlyPlanner
  module Adapters
    class Compiler
      DEFAULT_PARAMETERS = {
        runs: 1
      }.freeze

      def initialize(params, file_path)
        @params = RecursiveOpenStruct.new(DEFAULT_PARAMETERS.merge(params))
        @file_path = file_path
      end

      def compile(index_file)
        number = params.runs || 1

        number.times do
          `cd #{file_path} && pdflatex -halt-on-error #{index_file}`
        end

        raise "Error compiling #{index_file}" unless $CHILD_STATUS.success?
      end

      private

      attr_reader :params, :file_path
    end
  end
end
