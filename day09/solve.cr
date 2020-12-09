def read_input(file : String, part = 1)
  File.read_lines(file).map(&.to_i64)
end

def valid?(input, caret = 25, limit = 25)
  value = input[caret]

  (caret - 1).downto(caret - limit + 1).each do |i|
    expect = value - input[i]

    (i - 1).downto(caret - limit).each do |j|
      return true if input[j] == expect
    end
  end

  false
end

def solve_part1(input, limit = 25)
  limit.upto(input.size - 1) do |caret|
    return {caret, input[caret]} unless valid?(input, caret, limit)
  end
end

def find_range(input, caret, value)
  (caret - 1).downto(1).each do |i|
    acc = input[i]

    (i - 1).downto(0).each do |j|
      acc += input[j]
      case acc <=> value
      when  1 then break
      when -1 then next
      else
        return {j, i}
      end
    end
  end
end

def solve_part2(input, limit = 25)
  return unless res = solve_part1(input, limit)
  caret, value = res

  return unless range = find_range(input, caret, value)
  lower, upper = range

  min = max = input[lower]
  input[lower..upper].each do |val|
    min = val if min > val
    max = val if max < val
  end

  {min, max}.sum
end

INP_FILE = {{ __DIR__ }} + "/input.txt"

puts "- part 1: #{solve_part1(read_input(INP_FILE), limit: 25)}"
puts "- part 2: #{solve_part2(read_input(INP_FILE), limit: 25)}"
