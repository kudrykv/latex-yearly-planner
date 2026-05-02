# frozen_string_literal: true

module LYP
  module Services
    class Compile
      OUTPUT_FILE = "index.pdf"
      TEMP_FILE = "temp.pdf"

      def compile(workdir:, file:, enable_ghostscript: false)
        compile_typst(workdir:, file:)
        run_ghostscript(workdir:) if enable_ghostscript
      end

      private

      def compile_typst(workdir:, file:)
        puts "Compiling with typst..."
        time = Benchmark.measure do
          system("typst", "compile", File.join(workdir, file), File.join(workdir, OUTPUT_FILE), exception: true)
        end

        puts "Typst compilation time: #{time.real.round(2)}s"
      end

      def run_ghostscript(workdir:)
        puts "Running Ghostscript..."
        time = Benchmark.measure { system(*ghostscript_cmd(workdir:), exception: true) }
        puts "Ghostscript time: #{time.real.round(2)}s"

        FileUtils.mv(File.join(workdir, TEMP_FILE), File.join(workdir, OUTPUT_FILE))
      end

      def ghostscript_cmd(workdir:)
        [
          "gs",
          "-sDEVICE=pdfwrite",
          "-dCompatibilityLevel=1.5",
          "-dNOPAUSE",
          "-dQUIET",
          "-dBATCH",
          "-dAutoRotatePages=/None",
          "-sOutputFile=#{File.join(workdir, TEMP_FILE)}",
          File.join(workdir, OUTPUT_FILE)
        ]
      end
    end
  end
end
