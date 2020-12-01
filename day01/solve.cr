INP_FILE = {{ __DIR__ }} + "/input.txt"

def read_input(inp_file = INP_FILE)
  File.read_lines(inp_file).map(&.to_i)
end

def solve_part1
  input = read_input

  0.upto(input.size - 2) do |i|
    a = input[i]

    (i + 1).upto(input.size - 1) do |j|
      b = input[j]
      next unless a + b == 2020

      puts a * b
      return
    end
  end

  puts "No result!"
end

def solve_part2
  input = read_input

  0.upto(input.size - 3) do |i|
    a = input[i]

    (i + 1).upto(input.size - 2) do |j|
      b = input[j]

      (j + 1).upto(input.size - 1) do |k|
        c = input[k]
        next unless a + b + c == 2020

        puts a * b * c

        return
      end
    end
  end

  puts "No result!"
end

solve_part1
solve_part2
