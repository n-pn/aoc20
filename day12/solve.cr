class Day12
  getter input = [] of Tuple(Char, Int32)

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)
    @input = File.read_lines(file).map do |line|
      dir = line[0]
      int = line[1..].to_i
      {dir, int}
    end
  end

  def part1
    x = y = 0
    cur = 0

    @input.each do |(dir, int)|
      case dir
      when 'E' then x += int
      when 'S' then y -= int
      when 'W' then x -= int
      when 'N' then y += int
      when 'L' then cur = (cur - int // 90) % 4
      when 'R' then cur = (cur + int // 90) % 4
      when 'F'
        case cur
        when 0 then x += int # 'E'
        when 1 then y -= int # 'S'
        when 2 then x -= int # 'W'
        when 3 then y += int # 'N'
        end
      end

      # pp [dir, int, x, y, cur]
    end

    {x, y, x.abs + y.abs}
  end

  def part2
    ship_x = 0
    ship_y = 0

    waypoint_x = 10
    waypoint_y = 1

    cur = 0

    @input.each do |(dir, int)|
      case dir
      when 'E' then waypoint_x += int
      when 'S' then waypoint_y -= int
      when 'W' then waypoint_x -= int
      when 'N' then waypoint_y += int
      when 'F'
        ship_x += waypoint_x * int
        ship_y += waypoint_y * int
      when 'L'
        case int
        when  90 then waypoint_x, waypoint_y = -waypoint_y, waypoint_x
        when 180 then waypoint_x, waypoint_y = -waypoint_x, -waypoint_y
        when 270 then waypoint_x, waypoint_y = waypoint_y, -waypoint_x
        end
      when 'R'
        case int
        when  90 then waypoint_x, waypoint_y = waypoint_y, -waypoint_x
        when 180 then waypoint_x, waypoint_y = -waypoint_x, -waypoint_y
        when 270 then waypoint_x, waypoint_y = -waypoint_y, waypoint_x
        end
      end

      pp [{dir, int}, {waypoint_x, waypoint_y}, {ship_x, ship_y}, cur]
    end

    {ship_x, ship_y, ship_x.abs + ship_y.abs}
  end
end

solver = Day12.new("test0.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"

solver = Day12.new("input.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"
