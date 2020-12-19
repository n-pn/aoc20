class Day19
  @inputs : Array(String)
  @rules = {} of Int32 => String

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)
    lines, @inputs = File.read(file).split("\n\n").map(&.split("\n"))

    lines.each do |line|
      key, val = line.split(": ", 2)
      @rules[key.to_i] = val.tr("\"", "")
    end
  end

  def build_regex(key : Int32) : String
    regexes = @rules[key].split(" | ").map { |x| build_regex(x) }
    regexes.size > 1 ? "(" + regexes.join("|") + ")" : regexes[0]
  end

  def build_regex(rule : String) : String
    return rule if rule == "a" || rule == "b"
    rule.split(" ").map { |x| build_regex(x.to_i) }.join
  end

  def part1
    regex = /^#{build_regex(0)}$/
    valids = @inputs.select { |input| input =~ regex }

    valids.size
  end

  def part2
    regex = /^#{build_regex2(0)}$/
    valids = @inputs.select { |input| input =~ regex }
    valids.size
  end

  def build_regex2(key : Int32) : String
    case key
    when 8 then "(" + build_regex2(42) + ")+"
    when 11
      regex_42 = build_regex2(42)
      regex_31 = build_regex2(31)

      x = {
        "(#{regex_42}){1}(#{regex_31}){1}",
        "(#{regex_42}){2}(#{regex_31}){2}",
        "(#{regex_42}){3}(#{regex_31}){3}",
        "(#{regex_42}){4}(#{regex_31}){4}",
        "(#{regex_42}){5}(#{regex_31}){5}",
      }

      "(#{x.join('|')})"
    else
      regexes = @rules[key].split(" | ").map { |x| build_regex2(x) }
      regexes.size > 1 ? "(#{regexes.join('|')})" : regexes[0]
    end
  end

  def build_regex2(rule : String) : String
    return rule if rule == "a" || rule == "b"
    rule.split(" ").map { |x| build_regex2(x.to_i) }.join
  end
end

solver = Day19.new("input.txt")
# solver = Day19.new("test0.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"
