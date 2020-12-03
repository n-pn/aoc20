def read_input(file : String)
  File.read_lines(file).map do |item|
    item.chars
  end
end

def solve_part1(input, right = 3, down = 1)
  count = 0_i64

  x = y = 0

  while x < input.size
    count += 1 if input[x][y] == '#'

    x += down
    y = (y + right) % input[0].size
  end

  count
end

def solve_part2(input)
  output = solve_part1(input, 1, 1)
  output *= solve_part1(input, 3, 1)
  output *= solve_part1(input, 5, 1)
  output *= solve_part1(input, 7, 1)
  output *= solve_part1(input, 1, 2)

  output
end

INP_FILE = {{ __DIR__ }} + "/input.txt"
input = read_input(INP_FILE)

puts "- part 1: #{solve_part1(input)}"
puts "- part 2: #{solve_part2(input)}"
