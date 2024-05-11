# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    class MosNav
      attr_reader :i18n, :navigation, :quarters, :quarters_navigation_params, :months, :months_navigation_params

      def initialize(i18n: I18n, navigation:, quarters:, quarters_navigation_params:, months:, months_navigation_params:)
        @i18n = i18n
        @navigation = navigation
        @quarters = quarters
        @quarters_navigation_params = quarters_navigation_params
        @months = months
        @months_navigation_params = months_navigation_params
      end

      def to_s
        navigation.map do |nav|
          next "\\vskip#{nav}" if nav.match?(/\A\d/)

          method(nav).call
        end.join("%\n")
      end

      private

      def quarters_navigation
        XTeX::VerticalStick.new(items: quarter_names, **quarters_navigation_params)
      end

      def quarter_names
        quarters.map { |quarter| "#{i18n.t('calendar.one_letter.quarter')}#{quarter.number}" }
      end

      def months_navigation
        XTeX::VerticalStick.new(items: month_names, **months_navigation_params)
      end

      def month_names
        months.map(&method(:short_month_name))
      end

      def short_month_name(month)
        i18n.t("calendar.short.month.#{month.name.downcase}")
      end
    end
  end
end
