require_relative '../aoc/syntax_engine'

RSpec.describe AOC::SyntaxEngine do

  context "perfect input pattern" do
    subject { AOC::SyntaxEngine.new '{{}()<[]>}' }
    it "is not corrupt" do
      expect(subject.corrupt).to be false
    end

    it "is complete" do
      expect(subject.incomplete?).to be false
    end

    it "scores 0" do
      expect(subject.score).to eq 0
    end
  end

  context "complete but input corrupt due to angle" do
    subject { AOC::SyntaxEngine.new '{{}(><[]>}' }
    it "is corrupt" do
      expect(subject.corrupt).to be true
    end

    it "is complete" do
      expect(subject.incomplete?).to be false
    end
    it "scores" do
      expect(subject.score).to eq 25137
    end
  end

  context "valid but incomplete input" do
    subject { AOC::SyntaxEngine.new '[({(<(())[]>[[{[]{<()<>>' }
    it "is not corrupt" do
      expect(subject.corrupt).to be false
    end

    it "is incomplete" do
      expect(subject.incomplete?).to be true
    end
    it "scores 0" do
      expect(subject.score).to eq 0
    end

    it "can calculate autocomplete_score" do
      expect(subject.autocomplete_score).to eq 288957
    end
  end
end
