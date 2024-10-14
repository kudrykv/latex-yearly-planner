# frozen_string_literal: true

module LatexYearlyPlanner
  module Planners
    class Page < Base
      attr_reader :name

      def initialize(name:, section_config:, i18n: I18n)
        super(section_config:, i18n:)

        @name = name
      end

      def page_id(suffix = nil)
        return name.to_s.downcase if suffix.nil?

        "#{name.to_s.downcase}-#{suffix}"
      end

      def page_to(name, suffix = nil)
        return "##{name.to_s.downcase}" if suffix.nil?

        "#{name.to_s.downcase}-#{suffix}"
      end
    end
  end
end
