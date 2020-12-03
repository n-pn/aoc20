# credit: https://gist.github.com/HeyItsBATMAN/d0e5d354040de578a32eb929f533769b

require "file_utils"
require "http/client"

current = Time.local
options = {"day" => current.day.to_s, "year" => current.year.to_s}
options.merge! ARGV.map(&.split("=")).to_h

def pad_zero(value : String | Int)
  "00#{value}".split("").last(2).join("")
end

def download_input(day, year = 2020)
  filename = "day#{pad_zero(day)}/input.txt"

  return puts "Input existed, skipping" if File.exists?(filename)
  FileUtils.mkdir_p(File.dirname(filename))

  puts "Downloading input for day #{day} year #{year}"

  input_url = "https://adventofcode.com/#{year}/day/#{day}/input"
  headers = HTTP::Headers{"cookie" => "session=#{ENV["AOC_SESSION"]}"}

  while true
    response = HTTP::Client.get(input_url, headers: headers)

    if response.status_code == 200
      File.write(filename, response.body)
      puts "Response written to #{filename}. Good luck!"
      break
    else
      puts "Failed getting input: #{response.status_code}"
    end

    sleep 15
  end
end

download_input day: options["day"], year: options["year"]
