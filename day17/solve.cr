struct Point
  property x : Int32
  property y : Int32
  property z : Int32

  def initialize(@x, @y, @z)
  end
end

struct Point2
  property x : Int32
  property y : Int32
  property z : Int32
  property w : Int32

  def initialize(@x, @y, @z, @w)
  end
end

class Day17
  property input : Array(String)

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)
    @input = File.read_lines(file)
  end

  def part1
    active = {} of Point => Bool

    @input.each_with_index do |line, x|
      line.chars.each_with_index do |char, y|
        active[Point.new(x, y, 0)] = true if char == '#'
      end
    end

    6.times do
      counts = Hash(Point, Int32).new { |h, k| h[k] = 0 }

      active.each do |key, val|
        next unless val

        -1.upto(1) do |i|
          -1.upto(1) do |j|
            -1.upto(1) do |k|
              next if i == 0 && j == 0 && k == 0
              counts[Point.new(key.x + i, key.y + j, key.z + k)] += 1
            end
          end
        end
      end

      new_active = {} of Point => Bool

      counts.each do |key, val|
        if active[key]?
          new_active[key] = true if val == 2 || val == 3
        elsif val == 3
          new_active[key] = true
        end
      end

      active = new_active
    end

    active.size
  end

  def part2
    active = {} of Point2 => Bool

    @input.each_with_index do |line, x|
      line.chars.each_with_index do |char, y|
        active[Point2.new(x, y, 0, 0)] = true if char == '#'
      end
    end

    6.times do
      counts = Hash(Point2, Int32).new { |h, k| h[k] = 0 }

      active.each do |key, val|
        next unless val

        -1.upto(1) do |i|
          -1.upto(1) do |j|
            -1.upto(1) do |k|
              -1.upto(1) do |l|
                next if i == 0 && j == 0 && k == 0 && l == 0
                counts[Point2.new(key.x + i, key.y + j, key.z + k, key.w + l)] += 1
              end
            end
          end
        end
      end

      new_active = {} of Point2 => Bool

      counts.each do |key, val|
        if active[key]?
          new_active[key] = true if val == 2 || val == 3
        elsif val == 3
          new_active[key] = true
        end
      end

      active = new_active
    end

    active.size
  end
end

solver = Day17.new("input.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"
