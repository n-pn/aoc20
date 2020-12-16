class Day16
  struct Range
    getter from : Int32
    getter upto : Int32

    def initialize(@from, @upto)
    end
  end

  getter notes = {} of String => Tuple(Range, Range)
  getter my_ticket : Array(Int32)
  getter nearby_tickets = [] of Array(Int32)

  NOTE_RE = /^(.+): (\d+)-(\d+) or (\d+)-(\d+)$/

  def initialize(fname : String = "input.txt")
    file = File.join({{ __DIR__ }}, fname)
    lines = File.read_lines(file)

    idx = 0
    while line = lines[idx]?
      idx += 1
      next if line.empty?
      break if line == "your ticket:"

      begin
        _, label, from_1, upto_1, from_2, upto_2 = NOTE_RE.match(line).not_nil!
        @notes[label] = {
          Range.new(from_1.to_i, upto_1.to_i),
          Range.new(from_2.to_i, upto_2.to_i),
        }
      end
    end

    @my_ticket = lines[idx].split(",").map(&.to_i)
    idx += 3

    while line = lines[idx]?
      idx += 1
      next if line.empty?
      @nearby_tickets << line.split(",").map(&.to_i)
    end
  end

  def invalid_value?(value : Int32)
    notes.each_key { |type| return false if valid_value?(value, type) }

    true
  end

  def valid_value?(value : Int32, type : String)
    range_1, range_2 = @notes[type]
    return true if value >= range_1.from && value <= range_1.upto
    return true if value >= range_2.from && value <= range_2.upto
    false
  end

  def invalid_ticket?(values : Array(Int32))
    values.each { |value| return true if invalid_value?(value) }
    false
  end

  def part1
    output = [] of Int32
    nearby_tickets.each do |tickets|
      tickets.each { |ticket| output << ticket if invalid_value?(ticket) }
    end

    output.sum
  end

  def valid_keys(value : Int32)
    Set(String).new @notes.keys.select { |key| valid_value?(value, key) }
  end

  def part2
    valid_fields = @my_ticket.map { |value| valid_keys(value) }

    @nearby_tickets.each do |ticket|
      next if invalid_ticket?(ticket)

      ticket.each_with_index do |value, idx|
        keys = valid_keys(value)
        valid_fields[idx] &= keys
      end
    end

    checked = Array(Bool).new(valid_fields.size, false)

    while true
      loop = false

      valid_fields.each_with_index do |keys, idx|
        next if checked[idx]
        next if keys.size > 1

        picked = keys.first
        checked[idx] = true

        valid_fields.each_with_index do |keys, jdx|
          next if jdx == idx
          keys.delete(picked)
        end

        loop = true
        break
      end

      break unless loop
    end

    output = 1_i64

    valid_fields.each_with_index do |keys, idx|
      next unless keys.first.starts_with?("departure")
      output *= @my_ticket[idx]
    end

    output
  end
end

solver = Day16.new("input.txt")
puts "- part 1: #{solver.part1}"
puts "- part 2: #{solver.part2}"
