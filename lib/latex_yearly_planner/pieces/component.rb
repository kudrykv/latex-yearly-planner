# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    class Component
      def initialize(config, section_config)
        @config = config
        @section_config = section_config
      end

      def generate
        raise NotImplementedError
      end

      private

      attr_reader :config, :section_config

      def param(key)
        @param ||= {}

        @param[key] ||= section_config.parameters.send(key) || config.parameters.parameters.send(key)
      end
    end
  end
end
