# frozen_string_literal: true

require 'rspec'

RSpec.describe LatexYearlyPlanner::Planners::Mos::Pages::Annual do
  subject(:page) { described_class.new(section_config:) }

  let(:month_rows) do
    [
      [
        LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: 1),
        LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: 2)
      ],
      [
        LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: 3),
        LatexYearlyPlanner::Calendar::Month.new(weekday_start:, year:, month: 4)
      ]
    ]
  end
  let(:weekday_start) { :monday }
  let(:year) { 2024 }
  let(:section_config) { instance_double(LatexYearlyPlanner::Adapters::SectionConfig) }
  let(:config_operator) { instance_double(LatexYearlyPlanner::Adapters::ConfigOperator) }

  before do
    I18n.load_path = Dir['locales/*.yaml']
    I18n.locale = :en
  end

  describe '#title' do
    before do
      allow(section_config).to receive(:params).and_return(config_operator)
      allow(config_operator).to receive(:get).with(:heading_size).and_return('16pt')
      allow(config_operator).to receive(:get).with(:months_per_page).and_return(4)
      allow(config_operator).to receive(:months).and_return(month_rows.flatten)
    end

    it 'checks title' do
      expect(page.set(month_rows).title).to eq <<~TYPST.squish
        text(16pt)[ Jan 2024 --- Apr 2024 <annual-1> ]
      TYPST
    end
  end
end
