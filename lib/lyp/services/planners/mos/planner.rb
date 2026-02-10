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
            index = Sections::Index.new(overseer:).generate
            rest = overseer.enabled_sections.map { |dto| section(overseer, dto).generate }.join(glue)

            [index, rest].join
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

          def glue = "#pagebreak()\n"
        end
      end
    end
  end
end
