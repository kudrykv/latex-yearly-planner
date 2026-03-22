# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Coordinator
        def initialize(dto, i18n:)
          self.i18n = i18n
          self.overseer = Overseer.new(dto)
          self.manifest = Manifest.new
        end

        # rubocop:disable Metrics/AbcSize
        def generate
          builder = Builder.new(i18n:, overseer:, manifest:)

          overseer.enabled_sections.map { |dto| section(dto) }
                  .each { |s| manifest.register_section(s.registered_section_name) }
                  .each { |s| s.register(manifest) }
                  .flat_map { |s| s.pages(manifest) }
                  .each { |page| builder.add(page) }

          builder.generate
        end

        # rubocop:enable Metrics/AbcSize

        private

        attr_accessor :i18n, :overseer, :manifest

        def section(dto)
          name = dto[:name]
          case dto[:class]
          when "cover_plain"
            Sections::CoverPlain.new(name:, i18n:, overseer:, **dto[:params])
          when "annual"
            Sections::Annual.new(name:, i18n:, overseer:, **dto[:params])
          when "quarterly"
            Sections::Quarterly.new(name:, i18n:, overseer:, **dto[:params])
          when "monthly"
            Sections::Monthly.new(name:, i18n:, overseer:, **dto[:params])
          when "weekly"
            Sections::Weekly.new(name:, i18n:, overseer:, **dto[:params])
          when "daily"
            Sections::Daily.new(name:, i18n:, overseer:, **dto[:params])
          else
            raise ConfigError, "unknown section: #{dto[:name]}"
          end
        end
      end
    end
  end
end
