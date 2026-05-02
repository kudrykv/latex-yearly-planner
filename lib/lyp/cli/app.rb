# frozen_string_literal: true

module LYP
  module CLI
    class App < Thor
      attr_accessor :i18n, :generate_handler

      def initialize(...)
        super

        self.i18n = I18n

        generate_service = Services::Generate.new(i18n:)
        compile_service = Services::Compile.new

        self.generate_handler = Handlers::Generate.new(generate_service:, compile_service:)
      end

      desc "generate <yaml-config>", "Generate planner using config"
      option :i18n_path,
             type: :string,
             aliases: "-i",
             desc: "Path to i18n files",
             default: "locales/*.yaml"
      option :i18n_locale,
             type: :string,
             aliases: "-l",
             desc: "Selected locale to use",
             default: "en"
      option :workdir,
             type: :string,
             aliases: "-w",
             desc: "Working directory, where generation and compilation will be done",
             default: "./out"
      option :with_ghostscript,
             type: :boolean,
             aliases: "-g",
             desc: "Run ghostscript after compilation (reduces PDF size)",
             default: false

      def generate(path_to_yaml)
        i18n.load_path = Dir[options[:i18n_path]]
        i18n.locale = options[:i18n_locale]

        generate_handler.generate(path_to_yaml, options[:workdir], with_ghostscript: options[:with_ghostscript])
      end
    end
  end
end
