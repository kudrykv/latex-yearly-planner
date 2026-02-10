# frozen_string_literal: true

module LYP
  module Services
    class Generate
      attr_accessor :planner_director

      def initialize(planner_director:)
        self.planner_director = planner_director
      end

      def generate(dto)
        sections(dto).map do |section|
          puts section
        end
      end

      private

      def sections(dto)
        sections = dto.dig(:planner, :sections)
        raise ConfigError, "planner.sections is nil" if sections.nil? || sections.empty?

        sections
      end
    end
  end
end
