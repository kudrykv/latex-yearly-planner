# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Planner
          attr_accessor :overseer

          def initialize(dto)
            self.overseer = Overseer.new(dto)
          end

          def generate
            overseer.enabled_sections.map do |dto|
              section(overseer, dto).generate
            end
          end

          private

          def section(overseer, dto)
            case dto[:name]
            when "weekly"
              Sections::Weekly.new(overseer:, **dto[:params])
            else
              raise ConfigError, "unknown section: #{dto[:name]}"
            end
          end
        end
      end
    end
  end
end
