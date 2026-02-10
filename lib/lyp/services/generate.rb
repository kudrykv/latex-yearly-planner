# frozen_string_literal: true

module LYP
  module Services
    class Generate
      def generate(dto)
        planner = select_planner(dto)

        planner.generate
      end

      private

      def select_planner(dto)
        case dto[:template]
        when "mos"
          Planners::MOS::Planner.new(dto)
        else
          raise ConfigError, "Bad template: #{template}"
        end
      end
    end
  end
end
