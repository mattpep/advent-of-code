data = ARGF.readlines.map &:strip

MAXSIZE = 70_000_000
NEEDED = 30_000_000

class Tree
  attr_accessor :files, :directories, :name, :type, :parent

  def initialize(name)
    self.files = []
    self.directories = []
    self.name = name
    self.parent = nil

    if name == '/'
      self.parent = self
      # self.directories << self
    end
  end

  def size
    files.sum {|f| f[:size]} + directories.sum {|d| d.size}
  end

  def deep_dirs
    directories + directories.map {|d| d.deep_dirs }.flatten
  end
end

root = Tree.new("/")
current = root
data.each do |line|
  if line.start_with? '$ cd'
    target =  line[5..-1]
    if target == ".."
      current = current.parent
      next
    elsif target == "/"
      current = root
    else
      current = current.directories.select {|d| d.name == target }.first
    end
  elsif line.start_with? '$ ls'
    next
  elsif line.start_with? 'dir '
    dirname = line[4..-1]
    d = Tree.new(dirname)
    d.parent = current
    current.directories << d
  else
    fields = line.split
    size = fields[0].to_i
    name = fields[1]
    current.files << { name: name, size: size }
  end
end

part1 = root.deep_dirs.select {|d| d.size <= 100000 }.map{|d| d.size }.sum
puts "Part 1 (sum of all dirs <= 100000): #{part1}"

space_used = root.size
space_free = MAXSIZE - space_used
space_to_be_freed = NEEDED - space_free
part2 = root.deep_dirs.select {|d| d.size >= space_to_be_freed }.map{|d| d.size }.min
puts "Part 2 (size of smallest directory to be removed): #{part2}"
