class Day18
  property input : Array(Array(Char))

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)
    @input = File.read_lines(file).map(&.gsub(" ", "").chars)
  end

  def eval(expr : Array(Char), from = 0, upto = expr.size - 1, part1 = true) : Int64
    if expr[from] == '('
      match = match_pair(expr, from)
      left = eval(expr, from + 1, match - 1, part1: part1)
      from = match
    else
      left = expr[from].to_i64
      return left if from == upto
    end

    ops = [] of Char
    vals = [left]
    from += 1

    while from < upto + 1
      ops << expr[from]
      from += 1

      if expr[from] == '('
        match = match_pair(expr, from)
        vals << eval(expr, from, match, part1: part1)
        from = match + 1
      else
        vals << expr[from].to_i64
        from += 1
      end
    end

    if part1
      vals.each_with_index do |val, idx|
        return val if idx == vals.size - 1

        case ops[idx]
        when '+' then vals[idx + 1] += val
        when '*' then vals[idx + 1] *= val
        end
      end

      vals.last
    else
      ops.each_with_index do |op, idx|
        next if ops[idx] == '*'
        vals[idx + 1] += vals[idx]
        vals[idx] = 1_i64
      end

      vals.reduce(1_i64) { |a, c| a * c }
    end
  end

  def match_pair(expr : Array(Char), from = 0)
    count = 0
    while from < expr.size
      case expr[from]
      when '(' then count += 1
      when ')' then count -= 1
      end
      return from if count == 0
      from += 1
    end

    expr.size - 1
  end

  def part1
    @input.map { |expr| eval(expr) }.sum
  end

  def part2
    @input.map { |expr| eval(expr, part1: false) }.sum
  end
end

solver = Day18.new("input.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"
