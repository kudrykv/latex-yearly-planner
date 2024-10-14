# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class PlannerConfig
      attr_reader :section_config_const, :config

      def initialize(hash, sectionConfig: TypstSectionConfig)
        @config = hash

        @section_config_const = sectionConfig
      end

      def locale
        (config[:locale] || 'en').to_sym
      end

      def template
        raise ConfigurationError, '`template` key is missing in configuration file' unless config[:template]

        config[:template]
      end

      def planner
        raise ConfigurationError, '`planner` key is missing in configuration file' unless config[:planner]

        config[:planner]
      end

      def sections
        raise ConfigurationError, '`sections` key is missing in configuration file' unless planner[:sections]

        planner[:sections].map(&method(:to_section_config))
      end

      private

      def to_section_config(section)
        keys = section.keys
        raise ConfigurationError, 'Only one section is allowed in section container' if keys.size > 1

        key = keys.first
        section_config_const.new(name: key, section_config: section[key], planner_config: self)
      end
    end
  end
end
