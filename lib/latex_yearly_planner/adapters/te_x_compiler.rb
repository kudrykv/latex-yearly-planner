# frozen_string_literal: true

require 'English'
module LatexYearlyPlanner
  module Adapters
    class TeXCompiler
      attr_reader :workdir, :planner_config

      def initialize(workdir:, planner_config:)
        @workdir = workdir
        @planner_config = planner_config
      end

      def compile(text_document)
        planner_config.config[:compile][:runs].times do
          `cd #{workdir} && xelatex -halt-on-error #{text_document.name}`
          raise "Error compiling #{text_document.name}" unless $CHILD_STATUS.success?
        end
      end
    end
  end
end
