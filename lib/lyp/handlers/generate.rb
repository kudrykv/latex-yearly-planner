# frozen_string_literal: true

module LYP
  module Handlers
    class Generate
      attr_accessor :generate_service

      def initialize(generate_service:)
        self.generate_service = generate_service
      end

      def generate(path_to_yaml, dir)
        yaml = YAML.load_file(path_to_yaml, symbolize_names: true)

        contents = generate_service.generate(yaml)

        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)

        File.write(File.join(dir, "index.typst"), contents)
      end
    end
  end
end
