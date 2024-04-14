# frozen_string_literal: true

FactoryBot.define do
  factory :sample_little_calendar, class: LatexYearlyPlanner::XTeX::LittleCalendar do
    transient do
      I18n.load_path += Dir["#{File.expand_path("locales")}/*.yaml"]

      weekday_start { :wednesday }
      year { 2022 }
      month_number { 2 }
      month { LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: month_number) }
      i18n { I18n }
      parameters do
        {
          with_week_numbers: true,
          week_number_placement: 'left',
          underline_weekdays: true,
          upperline_weekdays: true,
          week_vertical_line: true
        }
      end
    end

    initialize_with do
      new(month:, i18n: i18n, **parameters)
    end
  end

  factory :sample_little_calendar_compiled, class: String do
    initialize_with do
      <<~LATEX.strip
        \\adjustbox{valign=t}{{\\renewcommand{\\arraystretch}{1}%
        \\setlength{\\tabcolsep}{0pt}%
        \\begin{tabularx}{\\linewidth}{Y|YYYYYYY}
          \\multicolumn{8}{c}{February}\\\\
          \\hline
        W & W & T & F & S & S & M & T\\\\\\hline
          5 &  &  &  &  &  &  & 1\\\\
          6 & 2 & 3 & 4 & 5 & 6 & 7 & 8\\\\
          7 & 9 & 10 & 11 & 12 & 13 & 14 & 15\\\\
          8 & 16 & 17 & 18 & 19 & 20 & 21 & 22\\\\
          9 & 23 & 24 & 25 & 26 & 27 & 28 & \\\\
        \\end{tabularx}}}
      LATEX
    end
  end
end
