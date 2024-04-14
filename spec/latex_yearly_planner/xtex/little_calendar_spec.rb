# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::XTeX::LittleCalendar do
  describe 'sample month' do
    let(:little_calendar) { build(:sample_little_calendar) }
    let(:compiled) { build(:sample_little_calendar_compiled) }

    it 'generates the correct LaTeX code' do
      expect(little_calendar.to_s).to eq(compiled)
    end
  end
end
