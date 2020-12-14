class Day14
  class Input
    property mark : String
    property mem = [] of Tuple(Int32, Int32)

    def initialize(@mark)
    end
  end

  getter input : Array(Input) = [] of Input

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)

    lines = File.read_lines(file)
    lines.each do |line|
      if line.starts_with?("mask")
        @input << Input.new(line.sub("mask = ", ""))
      else
        _, key, val = line.match(/^mem\[(\d+)\] = (\d+)$/).not_nil!
        @input.last.mem << {key.to_i, val.to_i}
      end
    end
  end

  def part1
    output = {} of Int32 => Int64
    @input.each do |input|
      mark = input.mark.chars.reverse

      input.mem.each do |key, val|
        output[key] = apply_mark(val, mark)
      end
    end

    output.values.sum
  end

  def apply_mark(int, mark)
    str = int.to_s(base: 2).chars.reverse

    chars = mark.map_with_index do |char, idx|
      case char
      when '1' then '1'
      when '0' then '0'
      else          str[idx]? || '0'
      end
    end

    chars.reverse.join.to_i64(base: 2)
  end

  def part2
    output = {} of Int64 => Int64
    @input.each do |input|
      mark = input.mark.chars.reverse

      input.mem.each do |key, val|
        chars = key.to_s(base: 2).chars.reverse
        (mark.size - chars.size).times { chars << '0' }
        keys = apply_mark_2(chars, mark, 0)
        keys.each { |key| output[key] = val.to_i64 }
      end
    end

    output.values.sum
  end

  def apply_mark_2(key_chars, mark_chars, idx = 0)
    return [key_chars.reverse.join.to_i64(base: 2)] if idx >= mark_chars.size
    case mark_chars[idx]
    when '0'
      apply_mark_2(key_chars, mark_chars, idx + 1)
    when '1'
      key_chars[idx] = '1'
      apply_mark_2(key_chars, mark_chars, idx + 1)
    else
      key_chars[idx] = '1'
      res = apply_mark_2(key_chars, mark_chars, idx + 1)
      key_chars[idx] = '0'
      res.concat(apply_mark_2(key_chars, mark_chars, idx + 1))
    end
  end
end

solver = Day14.new("input.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"
