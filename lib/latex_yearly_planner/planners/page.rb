# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Page < Base
      attr_reader :name

      def initialize(name:, section_config:, i18n: I18n)
        super(section_config:, i18n:)

        @name = name
      end

      def page_id(page_number = 1)
        "#{name.to_s.downcase}-#{page_number}"
      end

      def page_to(name, number = 1)
        "##{name}-#{number}"
      end
    end
  end
end
