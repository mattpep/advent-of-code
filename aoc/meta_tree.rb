module AOC
  class MetaTree
    attr_accessor :children, :meta

    def initialize(data)
      child_count = data[0]
      meta_count = data[1]

      ptr = 2
      self.children = child_count.times.each_with_object([]) do |_, arr|
        item = MetaTree.new data[ptr..-1]
        arr << item
        ptr += item.size
      end

      self.meta = meta_count.times.each_with_object([]) do |item, meta|
        meta << data[ptr+item]
      end
    end

    def size
      2 + children.sum { |child| child.size } + meta.size
    end

    def metasum
      meta.sum + children.sum { |child| child.metasum }
    end
  end
end
