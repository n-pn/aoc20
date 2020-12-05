def read_input(file : String)
  File.read_lines(file).map(&.chars)
end

def bsearch(lower : Int32, upper : Int32, checks : Array(Bool))
  checks.each do |check|
    half = (lower + upper) / 2

    if check
      upper = half.floor.to_i
    else
      lower = half.ceil.to_i
    end
  end

  lower
end

def get_pos(pass : Array(Char))
  row = bsearch(0, 127, pass[0..6].map { |c| c == 'F' })
  col = bsearch(0, 7, pass[7..9].map { |c| c == 'L' })
  row * 8 + col
end

def solve_part1(input)
  max = 0

  input.each do |pass|
    pos = get_pos(pass)
    max = pos if max < pos
  end

  max
end

def solve_part2(input)
  input
    .map { |x| get_pos(x) }.sort
    .each_with_index do |pass, i|
      return pass + 1 if pass + 1 != passes[i + 1]?
    end
end

INP_FILE = {{ __DIR__ }} + "/input.txt"
input = read_input(INP_FILE)

puts "- part 1: #{solve_part1(input)}"
puts "- part 2: #{solve_part2(input)}"
