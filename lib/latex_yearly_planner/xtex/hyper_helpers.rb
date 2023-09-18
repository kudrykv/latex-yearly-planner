# frozen_string_literal: true

module LatexYearlyPlanner
  module XTeX
    module HyperHelpers
      def target_year(content, year:, page: 1)
        Hyper.new(content, page:, reference: year).target
      end

      def link_year(content, year:, page: 1)
        Hyper.new(content, page:, reference: year).link
      end

      def target_quarter(content, quarter:)
        Hyper.new(content, reference: quarter.reference).target
      end

      def link_quarter(content, quarter:)
        Hyper.new(content, reference: quarter.reference).link
      end
    end
  end
end
