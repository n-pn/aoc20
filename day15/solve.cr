class Day15
  getter input = [] of Int32

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)

    @input = File.read_lines(file).first.split(',').map(&.to_i)
    pp @input
  end

  def solve(limit = 2020)
    spoken = Hash(Int32, Array(Int32)).new { |h, k| h[k] = [] of Int32 }

    @input.each_with_index { |val, idx| spoken[val] << idx + 1 }
    last = @input.last

    (@input.size + 1).upto(limit) do |idx|
      prevs = spoken[last]
      last = prevs.size < 2 ? 0 : prevs[-1] - prevs[-2]
      spoken[last] << idx
    end

    last
  end

  def part2
  end
end

solver = Day15.new("input.txt")
puts "- part 1: #{solver.solve(2020)}"
puts "- part 2: #{solver.solve(30000000)}"
