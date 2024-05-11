# frozen_string_literal: true

FactoryBot.define do
  factory :sample_mos_heading_table, class: LatexYearlyPlanner::XTeX::MosHeadingTable do
    transient do
      page_name { 'page_name' }
      placement do
        [
          RecursiveOpenStruct.new({ function: 'page_name', position: 'l' }),
          RecursiveOpenStruct.new({ function: 'empty_cell_filler', position: 'X' }),
          RecursiveOpenStruct.new({ function: 'navigation', position: 'X' })
        ]
      end
      tabularx { {} }
      navigation { %w[foo bar baz] }
    end

    initialize_with do
      new(page_name:, placement:, tabularx:, navigation:)
    end

    factory :sample_mos_heading_table_compiled, class: String do
      initialize_with do
        <<~LATEX.strip
        {\\renewcommand{\\arraystretch}{1}%
        \\setlength{\\tabcolsep}{0pt}%
        \\begin{tabularx}{\\linewidth}{lXX}
          page_name &  & foo & bar & baz\\\\
        \\end{tabularx}}
      LATEX
      end
    end
  end
end
