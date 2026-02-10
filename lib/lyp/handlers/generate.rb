# frozen_string_literal: true

module LYP
  module Handlers
    class Generate
      attr_accessor :generate_service, :compile_service

      def initialize(generate_service:, compile_service:)
        self.generate_service = generate_service
        self.compile_service = compile_service
      end

      def generate(path_to_yaml, workdir)
        yaml = YAML.load_file(path_to_yaml, symbolize_names: true)

        contents = generate_service.generate(yaml)

        FileUtils.mkdir_p(workdir)

        File.write(File.join(workdir, "index.typst"), contents)

        compile_service.compile(workdir:, file: "index.typst")
      end
    end
  end
end
