# frozen_string_literal: true

require "thor"

module Lyp
  class App < Thor
    desc "generate <yaml-config>", "Generate planner using config"
    option :locales_file_pattern,
           type: :string,
           aliases: '-l',
           desc: 'Locales file pattern',
           default: 'locales/*.yaml'
    option :workdir,
           type: :string,
           aliases: '-w',
           desc: 'Working directory, where generation and compilation will be done',
           default: './out'
    def generate(path_to_yaml)
      puts "later"
    end
  end
end
