# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Sectioner
      def initialize(global_config)
        @global_config = global_config
      end

      def sections
        global_config
          .sections_as_a_hash
          .map { |name, section_config| [name, RecursiveOpenStruct.new(section_config, recurse_over_arrays: true)] }
          .select { |_, section_config| section_config.enabled }
          .map { |name, section_config| make_section(name, section_config) }
      end

      private

      attr_reader :global_config

      def make_section(name, section_config)
        header = component_constant(name, section_config, :header).new(name, global_config, section_config)
        body = component_constant(name, section_config, :body).new(name, global_config, section_config)

        section_constant(name, section_config).new(name, global_config, section_config, header, body)
      end

      def section_constant(section_name, section_config)
        'LatexYearlyPlanner::' \
        'Pieces::' \
        "#{section_template_name(section_config)}::" \
        'Sections::' \
        "#{section_name.to_s.camelize}".constantize
      end

      def component_constant(section_name, section_config, piece_name)
        'LatexYearlyPlanner::' \
        'Pieces::' \
        "#{component_template_name(section_config, piece_name)}::" \
        'Components::' \
        "#{section_name.to_s.camelize}#{piece_name.to_s.camelize}".constantize
      end

      def section_template_name(section_config)
        (section_config.section_template_name || template_name(section_config)).camelize
      end

      def component_template_name(section_config, piece_name)
        (section_config.send("#{piece_name}_template_name") || template_name(section_config)).camelize
      end

      def template_name(section_config)
        (section_config.template_name || global_config.parameters.template_name).camelize
      end
    end
  end
end
