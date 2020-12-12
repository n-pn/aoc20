class Day11
  getter input = [] of Array(Char)

  def initialize(fname : String = "input.txt")
    file = File.join(__DIR__, fname)

    list = File.read_lines(file).map do |line|
      line.chars.unshift('.').push('.')
    end

    @input << Array(Char).new(list.first.size, '.')
    @input.concat(list)
    @input << Array(Char).new(list.first.size, '.')
  end

  def part1
    current = @input.clone

    while true
      staging = current.clone

      1.upto(input.size - 2) do |i|
        1.upto(input.first.size - 2) do |j|
          case current[i][j]
          when 'L'
            staging[i][j] = '#' if occupied_1(current, i, j) == 0
          when '#'
            staging[i][j] = 'L' if occupied_1(current, i, j) >= 4
          end
        end
      end

      # print_input(staging)

      break if current == staging
      current = staging
    end

    current.map(&.count('#')).sum
  end

  def print_input(input)
    puts input.map(&.join).join("\n")
    puts "---"
  end

  ADJACENTS = {
    {-1, -1}, {-1, 0}, {-1, 1},
    {0, -1}, {0, 1},
    {1, -1}, {1, 0}, {1, 1},
  }

  def occupied_1(input, i, j)
    ADJACENTS.count { |(k, l)| input[i + k][j + l] == '#' }
  end

  def part2
    current = @input.clone

    while true
      staging = current.clone

      1.upto(input.size - 2) do |i|
        1.upto(input.first.size - 2) do |j|
          case current[i][j]
          when 'L'
            staging[i][j] = '#' if occupied_2(current, i, j) == 0
          when '#'
            staging[i][j] = 'L' if occupied_2(current, i, j) >= 5
          end
        end
      end

      break if current == staging
      current = staging
    end

    current.map(&.count('#')).sum
  end

  def occupied_2(input, i, j)
    count = 0

    ADJACENTS.each do |(k, l)|
      ik = i + k
      jl = j + l

      while true
        break if ik < 0 || ik >= input.size
        break if jl < 0 || jl >= input.first.size

        char = input[ik][jl]

        if char == '.'
          ik += k
          jl += l
        else
          count += 1 if char == '#'
          break
        end
      end
    end

    count
  end
end

# solver = Day11.new("test0.txt")
solver = Day11.new("input.txt")

puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"
