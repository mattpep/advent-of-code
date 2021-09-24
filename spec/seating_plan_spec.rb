require_relative '../aoc/seating_plan'
part1_sequence = [
  "L.LL.LL.LL LLLLLLL.LL L.L.L..L.. LLLL.LL.LL L.LL.LL.LL L.LLLLL.LL ..L.L..... LLLLLLLLLL L.LLLLLL.L L.LLLLL.LL",
  "#.##.##.## #######.## #.#.#..#.. ####.##.## #.##.##.## #.#####.## ..#.#..... ########## #.######.# #.#####.##",
  "#.LL.L#.## #LLLLLL.L# L.L.L..L.. #LLL.LL.L# #.LL.LL.LL #.LLLL#.## ..L.L..... #LLLLLLLL# #.LLLLLL.L #.#LLLL.##",
  "#.##.L#.## #L###LL.L# L.#.#..#.. #L##.##.L# #.##.LL.LL #.###L#.## ..#.#..... #L######L# #.LL###L.L #.#L###.##",
  "#.#L.L#.## #LLL#LL.L# L.L.L..#.. #LLL.##.L# #.LL.LL.LL #.LL#L#.## ..L.L..... #L#LLLL#L# #.LLLLLL.L #.#L#L#.##",
  "#.#L.L#.## #LLL#LL.L# L.#.L..#.. #L##.##.L# #.#L.LL.LL #.#L#L#.## ..L.L..... #L#L##L#L# #.LLLLLL.L #.#L#L#.##"
]

part2_sequence = [
  "L.LL.LL.LL LLLLLLL.LL L.L.L..L.. LLLL.LL.LL L.LL.LL.LL L.LLLLL.LL ..L.L..... LLLLLLLLLL L.LLLLLL.L L.LLLLL.LL",
  "#.##.##.## #######.## #.#.#..#.. ####.##.## #.##.##.## #.#####.## ..#.#..... ########## #.######.# #.#####.##",
  "#.LL.LL.L# #LLLLLL.LL L.L.L..L.. LLLL.LL.LL L.LL.LL.LL L.LLLLL.LL ..L.L..... LLLLLLLLL# #.LLLLLL.L #.LLLLL.L#",
  "#.L#.##.L# #L#####.LL L.#.#..#.. ##L#.##.## #.##.#L.## #.#####.#L ..#.#..... LLL####LL# #.L#####.L #.L####.L#",
  "#.L#.L#.L# #LLLLLL.LL L.L.L..#.. ##LL.LL.L# L.LL.LL.L# #.LLLLL.LL ..L.L..... LLLLLLLLL# #.LLLLL#.L #.L#LL#.L#",
  "#.L#.L#.L# #LLLLLL.LL L.L.L..#.. ##L#.#L.L# L.L#.#L.L# #.L####.LL ..#.#..... LLL###LLL# #.LLLLL#.L #.L#LL#.L#",
  "#.L#.L#.L# #LLLLLL.LL L.L.L..#.. ##L#.#L.L# L.L#.LL.L# #.LLLL#.LL ..#.L..... LLL###LLL# #.LLLLL#.L #.L#LL#.L#"
]

data1 = <<EOT
.......#.
...#.....
.#.......
.........
..#L....#
....#....
.........
#........
...#.....
EOT

data2 = <<EOT
.............
.L.L.#.#.#.#.
.............
EOT

data3 = <<EOT
.##.##.
#.#.#.#
##...##
...L...
##...##
#.#.#.#
.##.##.
EOT

RSpec.describe AOC::SeatingPlan do
  context "part 1" do
    subject {
      AOC::SeatingPlan.new part1_sequence[0].split, AOC::SeatingPlan::FUSSY, AOC::SeatingPlan::NEAR
    }

    it "is valid after each of 5 steps" do
      5.times do |x|
        subject.tick
        expect(subject.cells.map(&:join).join(' ')).to eq part1_sequence[x+1]
      end
    end

    it "is constant after 6 steps" do
      5.times { subject.tick }
      expect {
        subject.tick
      }.to_not change { subject.cells }
    end

    it "has population 37 after 6 steps" do
      5.times { subject.tick }
      expect(subject.population).to eq 37
    end
  end

  context "part 2" do
    context "seat adjacency tests" do
      context "starting state 1" do
        subject {
          AOC::SeatingPlan.new data1.split("\n"), AOC::SeatingPlan::TOLERANT, AOC::SeatingPlan::FAR
        }

        it "the vacant seat has 8 neighbours" do
          expect(subject.neighbour_cells(3,4).count {|y,x| subject.cells[y][x] == AOC::SeatingPlan::OCCUPIED }).to eq(8)
        end
      end

      context "starting state 2" do
        subject {
          AOC::SeatingPlan.new data2.split("\n"), AOC::SeatingPlan::TOLERANT, AOC::SeatingPlan::FAR
        }

        it "has 1 empty" do
          expect(subject.neighbour_cells(1,1).count {|y,x| subject.cells[y][x] == AOC::SeatingPlan::EMPTYSEAT }).to eq(1)
        end
        it "has 0 occupied" do
          expect(subject.neighbour_cells(1,1).count {|y,x| subject.cells[y][x] == AOC::SeatingPlan::OCCUPIED }).to eq(0)
        end
      end

      context "starting state 3" do
        subject {
          AOC::SeatingPlan.new data3.split("\n"), AOC::SeatingPlan::TOLERANT, AOC::SeatingPlan::FAR
        }
        it "has 0 occupied" do
          expect(subject.neighbour_cells(3,3).count {|y,x| subject.cells[y][x] == AOC::SeatingPlan::OCCUPIED }).to eq(0)
        end
      end
    end
    context "tick tests" do
      subject {
        AOC::SeatingPlan.new part2_sequence[0].split, AOC::SeatingPlan::TOLERANT, AOC::SeatingPlan::FAR
      }
      5.times do |xx|
        it "is valid after each of n steps(#{xx+1})" do
          xx.times do |x|
            subject.tick
            expect(subject.cells.map(&:join).join(' ')).to eq part2_sequence[x+1]
          end
        end
      end
      it "is constant after 6 steps" do
        6.times do
          subject.tick
        end
        expect {
          subject.tick
        }.to_not change { subject.cells }
      end
    end
    context "long test" do
      subject {
      AOC::SeatingPlan.new part2_sequence[0].split, AOC::SeatingPlan::TOLERANT, AOC::SeatingPlan::FAR
      }
      it "has population 26 after 6 steps" do
        6.times { subject.tick }
        expect(subject.population).to eq 26
      end
    end
  end
end
