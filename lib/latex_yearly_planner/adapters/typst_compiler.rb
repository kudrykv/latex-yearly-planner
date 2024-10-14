# frozen_string_literal: true

require 'English'

module LatexYearlyPlanner
  module Adapters
    class TypstCompiler
      attr_reader :workdir, :planner_config

      def initialize(workdir:, planner_config:)
        @workdir = workdir
        @planner_config = planner_config
      end

      def compile(text_document)
        `typst compile #{workdir}/#{text_document.name}`
      end
    end
  end
end
