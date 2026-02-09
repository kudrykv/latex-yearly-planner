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
        puts 'Compiling generated document with Typst...'
        typst_compile_time = Benchmark.measure do
          `typst compile #{workdir}/#{text_document.name} #{workdir}/#{OUTPUT_FILE}`
        end

        raise "Failed to compile #{text_document.name}" unless $CHILD_STATUS.success?

        puts "Typst compilation time: #{typst_compile_time.real.round(2)}s"

        run_ghostscript
      end

      private

      def run_ghostscript
        return unless planner_config.config.dig(:compiler, :ghostscript, :enable)

        puts 'Running Ghostscript...'
        time = Benchmark.measure { ghostscript_cmd }
        raise 'Failed to slim PDF' unless $CHILD_STATUS.success?

        puts "Ghostscript time: #{time.real.round(2)}s"

        `mv #{workdir}/#{TEMP_FILE} #{workdir}/#{OUTPUT_FILE}`
      end

      def ghostscript_cmd
        `gs \
          -sDEVICE=pdfwrite \
          -dCompatibilityLevel=1.5 \
          -dNOPAUSE \
          -dQUIET \
          -dBATCH \
          -dAutoRotatePages=/None \
          -sOutputFile=#{workdir}/#{TEMP_FILE} \
          #{workdir}/#{OUTPUT_FILE}`
      end
    end
  end
end
