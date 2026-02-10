# frozen_string_literal: true

class LYP::Handlers::Generate
  attr_accessor :generate_service

  def initialize(generate_service:)
    self.generate_service = generate_service
  end

  def generate(path_to_yaml)
    yaml = YAML.load_file(path_to_yaml, symbolize_names: true)

    generate_service.generate(yaml)
  end
end
