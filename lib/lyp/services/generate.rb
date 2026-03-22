# frozen_string_literal: true

module LYP
  module Services
    class Generate
      attr_accessor :i18n

      def initialize(i18n:)
        self.i18n = i18n
      end

      def generate(dto)
        select_planner(dto).generate
      end

      private

      def select_planner(dto)
        case dto[:template]
        when "mos"
          Planners::MOS::Coordinator.new(dto, i18n:)
        else
          raise ConfigError, "Bad template: #{dto[:template]}"
        end
      end
    end
  end
end
