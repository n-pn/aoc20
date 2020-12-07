def read_input(file : String, part = 1)
  output = Hash(String, Hash(String, Int32)).new { |h, k| h[k] = {} of String => Int32 }

  File.read(file).split("\n").each do |line|
    next if line.empty?

    outer, inners = line.split(" bags contain ", 2)

    inners.split(", ").each do |inner|
      _, count, bag = inner.match(/^(\d+) (.+) bags?\.?$/).not_nil!
      if part == 1
        output[bag][outer] = count.to_i
      else
        output[outer][bag] = count.to_i
      end
    rescue
      # pp inner
    end
  end

  output
end

def solve_part1(input)
  queue = input["shiny gold"].keys
  valid = Set(String).new(queue)

  while bag = queue.pop?
    nexts = input[bag].keys.reject { |x| valid.includes?(x) }
    queue.concat(nexts)
    valid.concat(nexts)
  end

  valid.size
end

def contains(input, bag) : Int32
  in_count = input[bag].map { |b, c| c * contains(input, b) }.sum
  in_count + 1
end

def solve_part2(input)
  contains(input, "shiny gold") - 1
end

INP_FILE = {{ __DIR__ }} + "/input.txt"

puts "- part 1: #{solve_part1(read_input(INP_FILE, part: 1))}"
puts "- part 2: #{solve_part2(read_input(INP_FILE, part: 2))}"
