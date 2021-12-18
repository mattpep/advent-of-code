data = ARGF.readline.strip

class Hash
  def version_sum
    return self[:version] if self[:type_id] == BinaryStream::TYPE_LITERAL
    return self[:version] + self[:content].map do |child|
      child.version_sum
    end.sum
  end
end

class BinaryStream
  attr_accessor :binary, :index

  TYPE_LITERAL = 4

  def self.hex_to_bin hex
    hex.chars.map do |char|
      char.to_i(16).to_s(2).rjust(4,'0')
    end.join
  end

  def initialize bin
    self.binary = bin
    self.index = 0
  end

  def read_packet
    ver = read_n_bits(3).reverse.to_i(2)
    type = read_n_bits(3).reverse.to_i(2)
    case type
    when TYPE_LITERAL
      children = read_literal
    else # TYPE_OPERATOR
      children = []
      len_type = read_n_bits(1).to_i
      case len_type
      when 0
        len = read_n_bits(15).reverse.to_i(2)
        while len > 0
          child = BinaryStream.new(self.binary[self.index..-1]).read_packet
          children << child
          len -= child[:length]
          self.index += child[:length]
        end
      when 1
        count = read_n_bits(11).reverse.to_i(2)
        count.times do
          sub = BinaryStream.new(self.binary[self.index..-1]).read_packet
          children << sub
          self.index += sub[:length]
        end
      end
    end
    {
      version: ver,
      type_id: type,
      content: children.dup,
      length: self.index
    }
  end

  def read_literal
    literal = ''
    flag = true
    while flag
      flag = !read_n_bits(1).to_i.zero?
      literal += read_n_bits(4).reverse
    end
    literal.to_i(2)
  end

  private

  def read_n_bits n
    value = binary[self.index...self.index+n]
    self.index += n
    value.reverse
  end
end


stream = BinaryStream.new BinaryStream.hex_to_bin data
outer = stream.read_packet

part1 = outer.version_sum
puts "Part1: #{part1.inspect}"
