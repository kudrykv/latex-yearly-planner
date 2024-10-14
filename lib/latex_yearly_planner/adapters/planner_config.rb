# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class PlannerConfig
      attr_reader :config

      def initialize(hash)
        @config = hash
      end

      def template
        raise ConfigurationError, '`template` key is missing in configuration file' unless config[:template]

        config[:template]
      end

      def locale
        (config[:locale] || 'en').to_sym
      end

      def document_options
        config[:document][:klass][:size]
      end

      def document_class
        config[:document][:klass][:name]
      end

      def fonts
        Fonter.new(**config[:document][:fonts] || {})
      end

      def paper
        config[:document][:paper]
      end

      def sections
        planner_sections.map(&method(:to_section_config))
      end

      def object(key)
        planner.dig(:objects, key)
      end

      def placement(key)
        planner.dig(:placements, key)
      end

      def planner
        raise ConfigurationError, '`planner` key is missing in configuration file' unless config[:planner]

        config[:planner]
      end

      private

      def to_section_config(section)
        keys = section.keys
        raise ConfigurationError, 'Only one section is allowed in section container' if keys.size > 1

        key = keys.first
        TypstSectionConfig.new(name: key, section_config: section[key], planner_config: self)
      end

      def planner_sections
        raise ConfigurationError, '`sections` key is missing in configuration file' unless planner[:sections]

        planner[:sections]
      end
    end
  end
end
