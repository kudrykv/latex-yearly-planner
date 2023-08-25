# frozen_string_literal: true

module LatexYearlyPlanner
  module Pieces
    module Mos
      class Config
        attr_reader :struct

        def initialize(struct)
          @struct = struct
        end

        def respond_to_missing?(...)
          struct.respond_to?(...)
        end

        def method_missing(...)
          struct.method_missing(...)
        end

        def little_calendar(section_name)
          global_week_parameters
            .merge(global_little_calendar_parameters)
            .merge(local_week_parameters(section_name))
            .merge(local_little_calendar_parameters(section_name))
        end

        def large_calendar(section_name)
          global_week_parameters
            .merge(local_week_parameters(section_name))
            .merge(section(section_name).parameters&.calendar&.parameters_as_a_hash || {})
        end

        def section(section)
          struct.sections.send(section)
        end

        private

        def global_week_parameters
          {
            show_week_numbers: global_parameters.show_week_numbers,
            week_number_placement: global_parameters.week_number_placement
          }.compact
        end

        def global_little_calendar_parameters
          global_parameters.little_calendar_as_a_hash&.compact || {}
        end

        def local_week_parameters(section_name)
          {
            show_week_numbers: section(section_name).parameters&.show_week_numbers,
            week_number_placement: section(section_name).parameters&.week_number_placement
          }.compact
        end

        def local_little_calendar_parameters(section_name)
          section(section_name).parameters&.little_calendar_as_a_hash&.compact || {}
        end

        def global_parameters
          struct.parameters.parameters
        end
      end
    end
  end
end
