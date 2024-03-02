# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class PlannerConfig
      attr_reader :config

      def initialize(hash)
        @config = RecursiveOpenStruct.new(hash, recurse_over_arrays: true)
      end

      def template
        raise ConfigurationError, '`template` key is missing in configuration file' unless config.template

        config.template
      end

      def locale
        (config.locale || 'en').to_sym
      end

      def document_options
        config.document.class.size
      end

      def document_class
        config.document.class.name
      end

      def paper
        config.document.paper
      end

      def sections
        planner_sections.map(&method(:to_section_config))
      end

      private

      def to_section_config(section)
        keys = section.to_h.keys
        raise ConfigurationError, 'Only one section is allowed in section container' if keys.size > 1

        name = keys.first
        SectionConfig.new(name:, section_config: section.send(name), planner_config: self)
      end

      def planner_sections
        raise ConfigurationError, '`sections` key is missing in configuration file' unless config.planner.sections

        planner.sections
      end

      def planner
        raise ConfigurationError, '`planner` key is missing in configuration file' unless config.planner

        config.planner
      end
    end
  end
end
