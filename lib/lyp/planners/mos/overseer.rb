# frozen_string_literal: true

module LYP
  module Services
    module Planners
      module MOS
        class Overseer
          attr_accessor :dto

          ALLOWED_WEEKDAYS = %i[monday tuesday wednesday thursday friday saturday sunday].freeze

          def initialize(dto)
            self.dto = dto
          end

          def enabled_sections
            sections = dto.dig(:planner, :sections)
            raise ConfigError, "No `planner.sections` found" if sections.nil? || sections.empty?

            sections.filter { |s| s[:enabled] }
          end

          def start_date
            day = Date.parse(dto.dig(:planner, :params, :start_date))
            Entities::Calendar::Day.new(weekday_start:, day:)
          rescue StandardError => e
            raise ConfigError, "planner.params.start_date: invalid: #{e.message}"
          end

          def end_date
            day = Date.parse(dto.dig(:planner, :params, :end_date))
            Entities::Calendar::Day.new(weekday_start:, day:)
          rescue StandardError => e
            raise ConfigError, "planner.params.end_date: invalid: #{e.message}"
          end

          def weekday_start
            start = dto.dig(:planner, :params, :weekday_start)
            raise ConfigError, "No `planner.params.weekday_start` found" if start.nil? || start.empty?

            start = start.downcase.to_sym

            unless ALLOWED_WEEKDAYS.include? start
              raise ConfigError, "Bad value #{start}, allowed values are #{ALLOWED_WEEKDAYS}"
            end

            start
          end

          def dig!(*path)
            value = dto.dig(*path)
            raise ConfigError, "#{path.map(&:to_s).join(".")} not found" if value.nil?

            value
          end
        end
      end
    end
  end
end
