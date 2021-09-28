require_relative '../aoc/moon_system'

seed1= <<EOT
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
EOT

seed2= <<EOT
<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>
EOT

RSpec.describe AOC::MoonSystem do
  subject { AOC::MoonSystem.new seed1.split("\n") }

  it "can be initialised" do
    expect(subject.class).to eq AOC::MoonSystem
  end

  context "after 10 steps" do
    before :each do 
      10.times { subject.step }
    end
    it "knows the positions of the 4 moons" do
      expect(subject.moons[0][:pos]).to eq({ x: 2, y: 1, z: -3 })
      expect(subject.moons[1][:pos]).to eq({ x: 1, y: -8, z: 0 })
      expect(subject.moons[2][:pos]).to eq({ x: 3, y: -6, z: 1 })
      expect(subject.moons[3][:pos]).to eq({ x: 2, y: 0, z: 4 })
    end
    it "knows the velocities of the 4 moons" do
      expect(subject.moons[0][:vel]).to eq({ x: -3, y: -2, z: 1 })
      expect(subject.moons[1][:vel]).to eq({ x: -1, y: 1, z: 3 })
      expect(subject.moons[2][:vel]).to eq({ x: 3, y: 2, z: -3 })
      expect(subject.moons[3][:vel]).to eq({ x: 1, y: -1, z: -1 })
    end
    it "calculates the system energy" do
      expect(subject.energy).to eq 179
    end
  end

  context "longer example" do
    subject { AOC::MoonSystem.new seed2.split("\n") }
    it "can be initialised" do
      expect(subject.class).to eq AOC::MoonSystem
    end

    context "after 100 steps" do
      before :each do
        100.times { subject.step }
      end
      it "calculates the sytem energy" do
        expect(subject.energy).to eq 1940
      end
    end
  end
end
