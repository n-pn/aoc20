def read_input(file : String, part = 1)
  File.read_lines(file).map do |line|
    opt, arg = line.split(" ")
    {opt, arg.to_i}
  end
end

def solve_part1(input)
  check = Set(Int32).new

  acc = 0
  idx = 0

  while idx < input.size
    opt, arg = input[idx]
    case opt
    when "nop"
      idx += 1
    when "acc"
      acc += arg
      idx += 1
    when "jmp"
      idx += arg
    end

    return {idx, acc} if check.includes?(idx)
    check.add(idx)
  end

  {idx, acc}
end

def solve_part2(input)
  0.upto(input.size - 1) do |idx|
    opt, arg = input[idx]

    case opt
    when "nop"
      input[idx] = {"jmp", arg}
    when "jmp"
      input[idx] = {"nop", arg}
    when "acc"
      next
    end

    jdx, acc = solve_part1(input)

    return {jdx, acc} if jdx >= input.size

    input[idx] = {opt, arg}
  end
end

INP_FILE = {{ __DIR__ }} + "/input.txt"

puts "- part 1: #{solve_part1(read_input(INP_FILE, part: 1))}"
puts "- part 2: #{solve_part2(read_input(INP_FILE, part: 2))}"
