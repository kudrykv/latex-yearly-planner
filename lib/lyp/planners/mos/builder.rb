# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      class Builder
        attr_accessor :i18n, :overseer, :manifest, :planner

        def initialize(dto, i18n:)
          self.i18n = i18n
          self.overseer = Overseer.new(dto)
          self.manifest = Manifest.new
          self.planner = Planner.new(overseer:, manifest:)
        end

        # rubocop:disable Metrics/AbcSize
        def generate
          overseer.enabled_sections
                  .map { |dto| section(overseer, dto) }
                  .each { |s| manifest.register_section(s.name) }
                  .each { |s| s.register(manifest) }
                  .each { |s| s.generate(planner, manifest) }

          planner.generate
        end

        # rubocop:enable Metrics/AbcSize

        private

        def section(overseer, dto)
          case dto[:name]
          when "weekly"
            sec = Sections::Weekly.new(i18n:, overseer:, **dto[:params])
          else
            raise ConfigError, "unknown section: #{dto[:name]}"
          end

          sec.define_singleton_method(:name) { dto[:name] }

          sec
        end
      end
    end
  end
end
