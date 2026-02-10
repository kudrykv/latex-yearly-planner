# frozen_string_literal: true

module LYP
  module Services
    class Generate
      def generate(dto)
        contents = select_planner(dto).generate
        p contents
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
