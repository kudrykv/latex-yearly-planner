# frozen_string_literal: true

RSpec.describe LatexYearlyPlanner::XTeX::Line do
  describe '#register' do
    it 'returns the expected TeX code' do
      expect(described_class.register).to eq <<~TEX.strip
        \\newcommand{\\myLineNormal}{\\hrule width \\linewidth height 0.4pt}
        \\newcommand{\\myLineColored}[1]{\\textcolor{#1}{\\myLineNormal}}
      TEX
    end
  end

  describe '#to_s' do
    it 'returns plain line when color is nil' do
      line = described_class.new
      expect(line.to_s).to eq '\myLineNormal{}'
    end

    it 'returns colored line when color is given' do
      line = described_class.new(color: 'red')
      expect(line.to_s).to eq '\myLineColored{red}'
    end
  end
end
