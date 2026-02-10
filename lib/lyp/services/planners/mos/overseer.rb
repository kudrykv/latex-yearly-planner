# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Overseer
          attr_accessor :dto

          def initialize(dto)
            self.dto = dto
          end

          def enabled_sections
            sections = dto.dig(:planner, :sections)
            raise ConfigError, "No `planner.sections` found" if sections.nil? || sections.empty?

            sections.filter { |s| s[:enabled] }
          end
        end
      end
    end
  end
end
