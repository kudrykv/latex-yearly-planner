# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Builder
          attr_accessor :i18n, :overseer

          def initialize(dto, i18n:)
            self.i18n = i18n
            self.overseer = Overseer.new(dto)
          end

          def generate
            manifest = Manifest.new
            planner = Planner.new(overseer:)

            overseer.enabled_sections
                    .map { |dto| section(overseer, dto) }
                    .each { |s| s.register(manifest) }
                    .each { |s| s.generate(planner, manifest) }

            planner.generate
          end

          private

          def section(overseer, dto)
            case dto[:name]
            when "weekly"
              Sections::Weekly.new(i18n:, overseer:, **dto[:params])
            else
              raise ConfigError, "unknown section: #{dto[:name]}"
            end
          end
        end
      end
    end
  end
end
