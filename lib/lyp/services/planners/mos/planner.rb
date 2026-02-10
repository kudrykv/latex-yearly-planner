# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Planner
          def generate(_dto, section)
            case section[:name]
            when "weekly"
              puts "weekly!"
            else
              raise ConfigError, "unknown section: #{section[:name]}"
            end
          end
        end
      end
    end
  end
end
