class Day13
  getter time : Int32
  getter buses = [] of Tuple(Int32, Int32)

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)
    line1, line2 = File.read_lines(file)

    @time = line1.to_i
    line2.split(",").each_with_index do |bus, idx|
      next unless bus = bus.to_i?
      @buses << {bus, idx % bus}
    end

    pp [@time, buses]
  end

  def part1
    min_bus = -1
    min_rem = 10000000

    buses.each do |bus, _id|
      rem = time % bus
      rem = bus - rem if rem > 0

      if rem < min_rem
        min_bus = bus
        min_rem = rem
      end
    end

    {min_bus, min_rem, min_bus * min_rem}
  end

  def part2(lower = 100000000000000)
    min = @buses[0][0]

    # TODO: check common dividers
    max = @buses.select { |k, v| v == 0 || v == min }.reduce(1) { |a, i| a * i[0] }
    cur = (lower // max) * max

    while true
      return (cur - min) if valid?(cur - min)
      cur += max
    end
  end

  def valid?(int : Int64)
    @buses.each do |bus, idx|
      return false unless (int + idx) % bus == 0
    end

    true
  end
end

solver = Day13.new("input.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"

solver = Day13.new("test0.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2(1_i64)}"
