INP_FILE = {{ __DIR__ }} + "/input.txt"

def read_input(inp_file = INP_FILE)
  data = File.read(inp_file)
end

def solve_part1
  input = read_input

  puts input
end

solve_part1
