# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Planner
          def generate(_whole_dto, dto)
            section(dto)
          end

          private

          def section(dto)
            case dto[:name]
            when "weekly"
              puts "weekly!"
            else
              raise ConfigError, "unknown section: #{section_dto[:name]}"
            end
          end
        end
      end
    end
  end
end
