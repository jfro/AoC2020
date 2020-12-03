defmodule AdventOfCode.Day02 do
  def check_pass(pass_line) do
    [_match, min, max, letter, string] = Regex.run(~r/(\d+)\-(\d+)\s(\w):\s+(\w+)/, pass_line)
    map = String.codepoints(string) |> Enum.frequencies()
    # IO.puts("#{letter}: #{map[letter]} within #{min} #{max}")
    min = String.to_integer(min)
    max = String.to_integer(max)

    case map[letter] do
      nil -> false
      c -> c >= min && c <= max
    end
  end

  def part1(args) do
    args
    |> Stream.map(&String.trim/1)
    |> Stream.map(&check_pass/1)
    |> Stream.filter(fn x -> x end)
    |> Enum.count()
  end

  def part2(args) do
  end
end
