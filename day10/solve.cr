def read_input(file : String, part = 1)
  input = File.read_lines(file).map(&.to_i).sort
  input << input.last + 3
end

def solve_part1(input)
  counter = Hash(Int32, Int32).new { |h, k| h[k] = 0 }
  counter[input.first] += 1

  0.upto(input.size - 2) do |i|
    a = input[i]
    b = input[i + 1]
    counter[b - a] += 1
  end

  count_1 = counter[1]
  count_3 = counter[3]
  {count_1, count_3, count_1 * count_3}
end

def solve_part2(input)
  acc = Array(Int64).new(input.size + 1, 0_i64)
  acc[0] = 1

  1.upto(input.size - 1) do |i|
    curr = input[i]
    acc[i] += 1 if curr <= 3

    (i - 1).downto(0) do |j|
      prev = input[j]

      # pp [i, curr, j, prev, acc[j]]

      break if curr - prev > 3
      acc[i] += acc[j]
    end
  end

  acc[input.size - 1]
end

INP_FILE = {{ __DIR__ }} + "/input.txt"

puts "- part 1: #{solve_part1(read_input(INP_FILE))}"
puts "- part 2: #{solve_part2(read_input(INP_FILE))}"
