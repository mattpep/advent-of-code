require_relative '../aoc/seabed'

RSpec.describe AOC::Seabed do
  subject do
    data = open('2021/data/9a.txt').readlines.map do |line|
      line.strip.chars.map &:to_i
    end
    AOC::Seabed.new data
  end
  context "finding neighbours" do
    it "it works in the corners" do
      expect(subject.neighbours(0,0).count).to eq 2
      expect(subject.neighbours(0,4).count).to eq 2
      expect(subject.neighbours(9,0).count).to eq 2
      expect(subject.neighbours(9,4).count).to eq 2
    end

    it "it works in the edges" do
      expect(subject.neighbours(0,2).count).to eq 3
      expect(subject.neighbours(2,0).count).to eq 3
      expect(subject.neighbours(6,9).count).to eq 3
    end
  end

  context 'calculating dimensions' do
    it 'width' do
      expect(subject.width).to eq 10
    end
    it 'height' do
      expect(subject.height).to eq 5
    end
  end

  context 'finding lowest points' do
    it 'from top right' do
      expect(subject.find_low_point_from(9,0)).to eq [9,0]
    end
    it 'from top left' do
      expect(subject.find_low_point_from(0,0)).to eq [1,0]
    end
    it 'from 4,4' do
      expect(subject.find_low_point_from(4,4)).to eq [6,4]
    end
  end

  it 'can calculate risk level' do
    expect(subject.risk_level).to eq 15
  end
end
