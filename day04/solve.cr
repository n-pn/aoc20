def read_input(file : String)
  output = [[] of String]

  File.read(file).split("\n").each do |line|
    if line.empty?
      output << [] of String
    else
      output.last.concat(line.split(/\s+/))
    end
  end

  output.reject(&.empty?)
end

REQUIRED = Set{"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}

def valid_passport?(item)
  data = {} of String => String

  item.each do |x|
    key, val = x.split(":")
    data[key] = val
  end

  keys = Set.new(data.keys)
  keys.superset?(REQUIRED)
end

def solve_part1(input)
  input.count { |item| valid_passport?(item) }
end

def valid_passport_2?(item)
  data = {} of String => String

  item.each do |x|
    key, val = x.split(":")
    data[key] = val
  end

  keys = Set.new(data.keys)
  return false unless keys.superset?(REQUIRED)

  return false unless byr = data["byr"].to_i?
  return false if byr < 1920 || byr > 2002

  return false unless iyr = data["iyr"].to_i?
  return false if iyr < 2010 || iyr > 2020

  return false unless eyr = data["eyr"].to_i?
  return false if eyr < 2020 || eyr > 2030

  return unless hgt = data["hgt"]
  return unless height = hgt[0..-3].to_i?

  case hgt
  when .ends_with?("cm")
    return false if height < 150 || height > 193
  when .ends_with?("in")
    return false if height < 59 || height > 76
  else
    return false
  end

  return false unless data["hcl"] =~ /^#[0-9a-f]{6}$/

  return false unless ecl = data["ecl"]
  return false unless {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}.includes?(ecl)

  return false unless data["pid"] =~ /^[0-9]{9}$/

  true
end

def solve_part2(input)
  input.count { |item| valid_passport_2?(item) }
end

INP_FILE = {{ __DIR__ }} + "/input.txt"
input = read_input(INP_FILE)

puts "- part 1: #{solve_part1(input)}"
puts "- part 2: #{solve_part2(input)}"
