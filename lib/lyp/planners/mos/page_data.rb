# frozen_string_literal: true

module LYP
  module Planners
    module MOS
      PageData = Data.define(
        :raw_typst,
        :title,
        :content,
        :page_id,
        :highlight_months,
        :highlight_quarters
      ) do
        def initialize(
          content:,
          raw_typst: false,
          title: nil,
          page_id: nil,
          highlight_months: [],
          highlight_quarters: []
        )
          super
        end

        def raw_typst? = raw_typst
      end
    end
  end
end
