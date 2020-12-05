import AOC

aoc 2020, 4 do
  #   def input_stream() do
  #     "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  # byr:1937 iyr:2017 cid:147 hgt:183cm

  # iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
  # hcl:#cfa07d byr:1929

  # hcl:#ae17e1 iyr:2013
  # eyr:2024
  # ecl:brn pid:760753108 byr:1931
  # hgt:179cm

  # hcl:#cfa07d eyr:2025 pid:166559648
  # iyr:2011 ecl:brn hgt:59in" |> String.split("\n\n") |> Stream.map(&String.trim/1)
  #   end
  def input_stream() do
    input_string() |> String.split("\n\n") |> Stream.map(&String.trim/1)
  end

  defp gen_map(entries) do
    entries
    |> Enum.reduce(%{}, fn entry, map ->
      value = entry |> String.slice(4..-1)
      key = entry |> String.slice(0..2) |> String.to_atom()
      Map.put(map, key, value)
    end)
  end

  defp validate_passport(passport) do
    case passport do
      %{:byr => _, :iyr => _, :eyr => _, :hgt => _, :hcl => _, :ecl => _, :pid => _} -> true
      %{} -> false
    end
  end

  def p1 do
    input_stream()
    |> Stream.map(&String.split(&1, [" ", "\n"]))
    |> Stream.map(&gen_map/1)
    |> Stream.map(&validate_passport/1)
    |> Stream.filter(fn x -> x end)
    |> Enum.count()
  end

  def p2 do
  end
end
