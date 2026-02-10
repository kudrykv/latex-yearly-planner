# frozen_string_literal: true

module LYP
  module CLI
    class App < Thor
      attr_accessor :generate_handler

      def initialize(...)
        super

        planner_builder = Services::Planners::Builder.new

        generate_service = LYP::Services::Generate.new(planner_builder:)

        self.generate_handler = LYP::Handlers::Generate.new(generate_service:)
      end

      desc "generate <yaml-config>", "Generate planner using config"
      option :locales_file_pattern,
             type: :string,
             aliases: "-l",
             desc: "Locales file pattern",
             default: "locales/*.yaml"
      option :workdir,
             type: :string,
             aliases: "-w",
             desc: "Working directory, where generation and compilation will be done",
             default: "./out"

      def generate(path_to_yaml)
        generate_handler.generate(path_to_yaml)
      end
    end
  end
end
