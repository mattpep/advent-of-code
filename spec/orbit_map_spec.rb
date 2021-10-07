require_relative '../aoc/orbit_map'

test_data1 = <<EOT
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
EOT

test_data2 = <<EOT
#{test_data1}
K)YOU
I)SAN
EOT

RSpec.describe AOC::OrbitMap do
  context "part 1" do
    subject { AOC::OrbitMap.new test_data1 }

    it "can count from a node to another" do
      expect(subject.path_length_from('D', 'COM')).to eq 3
    end

    it "can count from a node to itself" do
      expect(subject.path_length_from('D', 'D')).to eq 0
      expect(subject.path_length_from('COM', 'COM')).to eq 0
    end

    it "can count all orbits in the network" do
      expect(subject.count_orbits).to eq 42
    end
  end

  context 'part 2' do
    subject { AOC::OrbitMap.new test_data2 }

    it "can count transfers" do
      expect(subject.count_transfers_from('YOU', 'SAN')).to eq 4
    end
  end
end
