# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX

    class MosSideNav
      attr_reader :i18n, :struct, :quarters, :months

      def initialize(struct:, quarters:, months:, i18n: I18n)
        @i18n = i18n
        @quarters = quarters
        @months = months
        @struct = struct
      end

      def to_s
        struct[:placements].map(&method(:handle_placement)).join("%\n")
      end

      private

      def handle_placement(placement)
        return "\\vskip#{placement}" if placement.match?(/\A\d/)

        method(placement).call
      end

      def quarters_navigation
        VerticalStick.new(items: quarter_names, struct: struct[:objects][:quarter_navigation])
      end

      def quarter_names
        quarters.map { |quarter| "#{i18n.t('calendar.one_letter.quarter')}#{quarter.number}" }
      end

      def months_navigation
        VerticalStick.new(items: month_names, struct: struct[:objects][:month_navigation])
      end

      def month_names
        months.map do |month|
          i18n.t("calendar.short.month.#{month.name.downcase}")
        end
      end
    end
  end
end
