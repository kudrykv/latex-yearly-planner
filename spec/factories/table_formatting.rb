# frozen_string_literal: true

FactoryBot.define do
  factory :custom_table_formatting, class: LatexYearlyPlanner::TeX::TableFormatting do
    formatting { 'lll' }

    initialize_with { new(formatting) }
  end
end

