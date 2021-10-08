require_relative '../aoc/asteroid_field'

RSpec.describe AOC::AsteroidField do
  context "finding visible asteroids" do
    subject { AOC::AsteroidField.new open('2019/data/10a.txt').read }

    it "can count neighbouring asteroids" do
      expect(subject.visible_from(3,4).count).to eq 8
      expect(subject.visible_from(4,2).count).to eq 5
      expect(subject.visible_from(1,2).count).to eq 7
    end

    it "cannot see beyond asteroids" do
      list = subject.visible_from(3,4)
      expect(list).to include [2,2]
      expect(list).to_not include [1,0]
    end

  end

  context 'can find the best vantage point' do
    it 'in grid a' do
      grid = AOC::AsteroidField.new open('2019/data/10a.txt').read
      expect(grid.best).to eq [3,4]
    end

    it "in grid b" do
      grid = AOC::AsteroidField.new open('2019/data/10b.txt').read
      expect(grid.best).to eq [5,8]
    end
    it "in grid c" do
      grid = AOC::AsteroidField.new open('2019/data/10c.txt').read
      expect(grid.best).to eq [1,2]
    end
  end

  context "finding the path between two points" do
    subject { AOC::AsteroidField.new open('2019/data/10a.txt').read }
    it "when they are NE SW" do
      expect(subject.cells_between([1,6], [9,2])).to eq([[1,6], [3,5], [5,4], [7,3], [9,2] ])
      expect(subject.cells_between([1,4], [2,3])).to eq([[1,4], [2,3]])
    end

    it "when they are NW SE" do
      expect(subject.cells_between([1,2], [3,4])).to eq([[1,2], [2,3], [3,4]])
    end

    it "when they are N S" do
      expect(subject.cells_between([1,2], [1,6])).to eq([[1,2], [1,3], [1,4], [1,5], [1,6]])
    end
    it "when they are W E" do
      expect(subject.cells_between([4,4], [1,4])).to eq([[4,4], [3,4], [2,4], [1,4]])
    end
  end
end
