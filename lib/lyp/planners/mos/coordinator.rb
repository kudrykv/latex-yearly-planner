# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Coordinator
        def initialize(dto, i18n:)
          self.i18n = i18n
          self.configurator = Configurator.new(dto)
          self.manifest = Manifest.new
        end

        # rubocop:disable Metrics/AbcSize
        def generate
          builder = Builder.new(i18n:, configurator:, manifest:)

          configurator.enabled_sections.map { |dto| section(dto) }
                      .each { |s| manifest.register_section(s.section_name) }
                      .each { |s| s.register(manifest) }
                      .flat_map { |s| s.pages(manifest) }
                      .each { |page| builder.add(page) }

          builder.generate
        end

        # rubocop:enable Metrics/AbcSize

        private

        attr_accessor :i18n, :configurator, :manifest

        def section(dto)
          klass = components[dto[:class]]
          raise ConfigError, "unknown component: #{dto[:class]}" if klass.nil?

          section_name = dto.delete :name
          klass.new(section_name:, i18n:, manifest:, configurator:, **dto[:params])
        end

        def components
          @components ||= {
            "cover_plain" => Sections::CoverPlain,
            "annual" => Sections::Annual,
            "quarterly" => Sections::Quarterly,
            "monthly" => Sections::Monthly,
            "weekly" => Sections::Weekly,
            "daily" => Sections::Daily
          }.freeze
        end
      end
    end
  end
end
