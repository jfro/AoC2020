import AOC

aoc 2020, 2 do
  defp check_pass(pass_line) do
    [_match, min, max, letter, string] = Regex.run(~r/(\d+)\-(\d+)\s(\w):\s+(\w+)/, pass_line)
    map = String.codepoints(string) |> Enum.frequencies()
    min = String.to_integer(min)
    max = String.to_integer(max)

    case map[letter] do
      nil -> false
      c -> c >= min && c <= max
    end
  end

  defp check_pass2(pass_line) do
    [_match, pos1, pos2, letter, string] = Regex.run(~r/(\d+)\-(\d+)\s(\w):\s+(\w+)/, pass_line)
    chars = String.codepoints(string)
    pos1 = String.to_integer(pos1) - 1
    pos2 = String.to_integer(pos2) - 1
    char1 = chars |> Enum.at(pos1)
    char2 = chars |> Enum.at(pos2)

    cond do
      char1 == char2 -> false
      char1 == letter || char2 == letter -> true
      true -> false
    end
  end

  def p1 do
    input_stream()
    # |> Stream.map(&String.trim/1)
    |> Stream.map(&check_pass/1)
    |> Stream.filter(fn x -> x end)
    |> Enum.count()
  end

  def p2 do
    input_stream()
    # |> Stream.map(&String.trim/1)
    |> Stream.map(&check_pass2/1)
    |> Stream.filter(fn x -> x end)
    |> Enum.count()
  end
end
