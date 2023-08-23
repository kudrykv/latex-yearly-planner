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
          base = {
            show_week_numbers: struct.parameters.parameters.show_week_numbers,
            week_number_placement: struct.parameters.parameters.week_number_placement,
          }.merge(struct.parameters.parameters.little_calendar_as_a_hash)

          if section(section_name).parameters.show_week_numbers
            base = base.merge({ show_week_numbers: section(section_name).parameters.show_week_numbers })
          end

          if section(section_name).parameters.week_number_placement
            base = base.merge({ week_number_placement: section(section_name).parameters.week_number_placement })
          end

          if section(section_name).parameters.little_calendar_as_a_hash
            base = base.merge(section(section_name).parameters.little_calendar_as_a_hash)
          end

          base
        end

        def section(section)
          struct.sections.send(section)
        end
      end
    end
  end
end
