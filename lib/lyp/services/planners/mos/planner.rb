# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Planner
          attr_accessor :config

          def initialize(dto)
            self.config = Config.new(dto)
          end

          def generate
            section(dto).generate
          end

          private

          def section(dto)
            case dto[:name]
            when "weekly"
              Sections::Weekly.new(**dto[:params])
            else
              raise ConfigError, "unknown section: #{section_dto[:name]}"
            end
          end
        end
      end
    end
  end
end
