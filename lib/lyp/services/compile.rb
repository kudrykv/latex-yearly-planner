# frozen_string_literal: true

module LYP
  module Services
    class Compile
      OUTPUT_FILE = 'index.pdf'
      TEMP_FILE = 'temp.pdf'

      def compile(workdir:, file:, enable_ghostscript: false)
        typst_compile_time = Benchmark.measure do
          `typst compile #{File.join(workdir, file)} #{File.join(workdir, OUTPUT_FILE)}`
        end

        puts "Typst compilation time: #{typst_compile_time.real.round(2)}s"

        run_ghostscript if enable_ghostscript
      end

      private

      def run_ghostscript
        puts 'Running Ghostscript...'
        time = Benchmark.measure { ghostscript_cmd }
        raise 'Failed to slim PDF' unless $CHILD_STATUS.success?

        puts "Ghostscript time: #{time.real.round(2)}s"

        `mv #{File.join(workdir, TEMP_FILE)} #{File.join(workdir, OUTPUT_FILE)}`
      end

      def ghostscript_cmd
        `gs \
          -sDEVICE=pdfwrite \
          -dCompatibilityLevel=1.5 \
          -dNOPAUSE \
          -dQUIET \
          -dBATCH \
          -dAutoRotatePages=/None \
          -sOutputFile=#{File.join(workdir, TEMP_FILE)} \
          #{File.join(workdir, OUTPUT_FILE)}`
      end
    end
  end
end
