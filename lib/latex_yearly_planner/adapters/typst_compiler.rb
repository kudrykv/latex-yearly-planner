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

        raise "Failed to compile #{text_document.name}" unless $CHILD_STATUS.success?

        `gs \
          -sDEVICE=pdfwrite \
          -dCompatibilityLevel=1.5 \
          -dNOPAUSE \
          -dQUIET \
          -dBATCH \
          -dAutoRotatePages=/None \
          -sOutputFile=#{workdir}/output.pdf \
          #{workdir}/index.pdf`

        raise 'Failed to slim PDF' unless $CHILD_STATUS.success?
      end
    end
  end
end
