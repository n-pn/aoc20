def read_input(file : String)
  output = [[] of String]

  File.read(file).split("\n").each do |line|
    if line.empty?
      output << [] of String
    else
      output.last << line
    end
  end

  output
end

def count_group(group, type = 0)
  return 0 if group.empty?

  output = Set(Char).new(group[0].chars)
  return output.size if group.size == 1

  group[1..].each do |chars|
    if type == 0
      output += Set(Char).new(chars.chars)
    else
      output &= Set(Char).new(chars.chars)
    end
  end

  output.size
end

def solve_part1(input)
  input.map { |group| count_group(group, type: 0) }.sum
end

def solve_part2(input)
  input.map { |group| count_group(group, type: 1) }.sum
end

INP_FILE = {{ __DIR__ }} + "/input.txt"
input = read_input(INP_FILE)

puts "- part 1: #{solve_part1(input)}"
puts "- part 2: #{solve_part2(input)}"
