# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    module HyperHelpers
      def target_year(content, year:, page: 1)
        Hyper.new(content, page:, year:).target
      end

      def link_year(content, year:, page: 1)
        Hyper.new(content, page:, year:).link
      end

      def target_quarter(content, quarter:)
        Hyper.new(content, year: quarter.year, quarter: quarter.name).target
      end

      def link_quarter(content, quarter:)
        Hyper.new(content, year: quarter.year, quarter: quarter.name).link
      end
    end
  end
end
