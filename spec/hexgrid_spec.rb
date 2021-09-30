require_relative '../aoc/hexgrid'
RSpec.describe AOC::HexGrid do
  subject { AOC::HexGrid.new 10, 'x' }

  context "part 1" do
    it "can track simple paths" do
      expect(subject.walk_path([0,0], %w[e w])).to eq [0,0]
      expect(subject.walk_path([0,0], %w[e e])).to eq [2,0]
      expect(subject.walk_path([0,0], %w[se se ne nw e])).to eq [2,0]
    end
  end
  context "part 2" do
    context 'counting neighbours' do
      it "at the top or left of the grid" do
        expect(subject.neighbours_of([0,0])).to eq Set[ {same: [1,0]}, {below: [0,1]} ]
        expect(subject.neighbours_of([1,0])).to eq Set[ {same: [0,0]}, {same: [2,0]}, {below: [0,1]}, {below: [1,1] }]
        expect(subject.neighbours_of([0,1])).to eq Set[ {above: [0,0]}, {above: [1,0]}, {same: [1,1]}, {below: [0,2]}, {below: [1,2]} ]
      end
      it 'works in the middle of the grid' do
        expect(subject.neighbours_of([1,1])).to eq Set[ {same: [0,1]}, {same: [2,1]}, {above: [1,0]}, {above: [2,0]}, {below: [1,2]}, {below: [2,2]} ]
      end
    end
  end
end
