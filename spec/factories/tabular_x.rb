# frozen_string_literal: true

FactoryBot.define do
  factory :tabularx, class: LatexYearlyPlanner::TeX::TabularX do
    transient do
      first_sample_row { %w[a b c d] }
      second_sample_row { %w[e f g h] }
    end

    width { '10cm' }
    vertical_stretch { 1.5 }
    horizontal_spacing { '6pt' }
    formatting { association :custom_table_formatting, formatting: 'llrr' }
    sample_rows do
      [
        LatexYearlyPlanner::TeX::TableRow.new(first_sample_row),
        LatexYearlyPlanner::TeX::TableRow.new(second_sample_row)
      ]
    end

    trait :sample do
      initialize_with do
        new(width:, vertical_stretch:, horizontal_spacing:, rows: sample_rows, formatting:)
      end
    end

    factory :sample_tabularx, traits: [:sample]
  end

  factory :sample_compiled, class: String do
    initialize_with do
      <<~TEX
        {\\renewcommand{\\arraystretch}{1.5}%
        \\setlength{\\tabcolsep}{6pt}%
        \\begin{tabularx}{10cm}{llrr}
          a & b & c & d\\\\
          e & f & g & h\\\\
        \\end{tabularx}}
      TEX
        .strip
    end
  end
end
