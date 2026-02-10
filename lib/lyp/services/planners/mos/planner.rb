# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Planner
          def generate(_whole_dto, dto)
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
