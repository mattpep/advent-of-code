require_relative '../aoc/meta_tree'
RSpec.describe AOC::MetaTree do
  subject { AOC::MetaTree.new [ 2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2 ] }
 
  it "can parse" do
    expect(subject).to be_a(AOC::MetaTree)
  end
  it "counts children" do
    expect(subject.children.count).to eq 2
  end
  it "counts meta entries" do
    expect(subject.meta.count).to eq 3
  end
  it "counts meta entries" do
    expect(subject.meta.count).to eq 3
  end
  it "calculates the meta sum" do
    expect(subject.metasum).to eq 138
  end
end
