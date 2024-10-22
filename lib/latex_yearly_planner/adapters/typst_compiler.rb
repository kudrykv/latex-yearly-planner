# frozen_string_literal: true

require 'English'

module LatexYearlyPlanner
  module Adapters
    class TypstCompiler
      attr_reader :workdir, :planner_config

      OUTPUT_FILE = 'index.pdf'
      TEMP_FILE = 'temp.pdf'

      def initialize(workdir:, planner_config:)
        @workdir = workdir
        @planner_config = planner_config
      end

      def compile(text_document)
        `typst compile #{workdir}/#{text_document.name} #{workdir}/#{OUTPUT_FILE}`

        raise "Failed to compile #{text_document.name}" unless $CHILD_STATUS.success?

        run_ghostscript
      end

      private

      def run_ghostscript
        return unless planner_config.config.dig(:compiler, :ghostscript, :enable)

        `gs \
          -sDEVICE=pdfwrite \
          -dCompatibilityLevel=1.5 \
          -dNOPAUSE \
          -dQUIET \
          -dBATCH \
          -dAutoRotatePages=/None \
          -sOutputFile=#{workdir}/#{TEMP_FILE} \
          #{workdir}/#{OUTPUT_FILE}`

        raise 'Failed to slim PDF' unless $CHILD_STATUS.success?

        `mv #{workdir}/#{TEMP_FILE} #{workdir}/#{OUTPUT_FILE}`
      end
    end
  end
end
