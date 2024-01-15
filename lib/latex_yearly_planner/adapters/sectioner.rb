# frozen_string_literal: true

module LatexYearlyPlanner
  module Adapters
    class Sectioner
      def initialize(config)
        @config = config
      end

      def sections
        config
          .sections_as_a_hash
          .map { |name, opts| [name, RecursiveOpenStruct.new(opts, recurse_over_arrays: true)] }
          .select { |_, opts| opts.enabled }
          .map { |name, opts| make_section(name, opts) }
      end

      private

      attr_reader :config

      def make_section(name, opts)
        header = component_constant(name, opts, :header).new(name, config, opts)
        body = component_constant(name, opts, :body).new(name, config, opts)

        section_constant(name, opts).new(name, config, opts, header, body)
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
        (section_config.template_name || config.parameters.template_name).camelize
      end
    end
  end
end
