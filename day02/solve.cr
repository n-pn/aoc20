INP_FILE = {{ __DIR__ }} + "/input.txt"

def read_input(inp_file = INP_FILE)
  File.read_lines(inp_file).map do |line|
    range, char, pass = line.split(" ")

    min, max = range.split("-").map(&.to_i)
    char = char[0]

    {min, max, char, pass}
  end
end

def solve_part1
  input = read_input
  count = 0

  read_input.each do |min, max, char, pass|
    tally = pass.count(char)
    count += 1 unless tally < min || tally > max
  end

  puts count
end

def solve_part2
  input = read_input
  count = 0

  read_input.each do |min, max, char, pass|
    x = 0
    x += 1 if pass[min - 1]? == char
    x += 1 if pass[max - 1]? == char
    count += 1 if x == 1
  end

  puts count
end

# solve_part1
solve_part2
