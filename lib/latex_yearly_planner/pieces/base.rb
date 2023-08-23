# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Base
      attr_reader :config, :section_config, :section_name

      def initialize(section_name, config, section_config)
        @section_name = section_name
        @config = config
        @section_config = section_config
      end

      def param(key)
        @param ||= {}

        @param[key] ||= section_config.parameters.send(key) || config.parameters.parameters.send(key)
      end
    end
  end
end
