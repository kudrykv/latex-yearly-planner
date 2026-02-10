# frozen_string_literal: true

module LYP
  module Services
    class Generate
      def initialize

      end

      def generate(dto)
        planner = select_planner(dto.dig(:template))

        sections(dto).map do |section|
          puts section
        end
      end

      private

      def select_planner(template)
        case template
        when "mos"
          Planners::MOS::Planner.new
        else
          raise ConfigError, "Bad template: #{template}"
        end
      end

      def sections(dto)
        sections = dto.dig(:planner, :sections)
        raise ConfigError, "planner.sections is blank" if sections.nil? || sections.empty?

        sections
      end
    end
  end
end
