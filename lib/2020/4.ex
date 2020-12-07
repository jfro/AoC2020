import AOC

aoc 2020, 4 do
  # def input_stream() do
  #   "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  # byr:1937 iyr:2017 cid:147 hgt:183cm

  # iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
  # hcl:#cfa07d byr:1929

  # hcl:#ae17e1 iyr:2013
  # eyr:2024
  # ecl:brn pid:760753108 byr:1931
  # hgt:179cm

  # hcl:#cfa07d eyr:2025 pid:166559648
  # iyr:2011 ecl:brn hgt:59in" |> String.split("\n\n") |> Stream.map(&String.trim/1)
  # end

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

  defp validate_year(year, range) do
    Enum.member?(range, String.to_integer(year))
  end

  defp validate_height(height) do
    validate_value = fn value, type ->
      case type do
        "in" -> Enum.member?(59..76, value)
        "cm" -> Enum.member?(150..193, value)
      end
    end

    case Regex.run(~r/(\d+)(in|cm)/, height) do
      [_match, value, type] -> validate_value.(String.to_integer(value), type)
      nil -> false
    end
  end

  defp validate_hcl(hcl) do
    case Regex.run(~r/#([a-f0-9]{6})/, hcl) do
      [_match, _value] ->
        true

      nil ->
        false
    end
  end

  defp validate_ecl(ecl) do
    valid = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    Enum.member?(valid, ecl)
  end

  defp validate_pid(pid) do
    case Regex.run(~r/\d{9}/, pid) do
      [_match] ->
        true

      nil ->
        false
    end
  end

  defp validate_passport_fields(passport) do
    validate_year(passport[:byr], 1920..2002) && validate_year(passport[:iyr], 2010..2020) &&
      validate_year(passport[:eyr], 2020..2030) && validate_height(passport[:hgt]) &&
      validate_hcl(passport[:hcl]) && validate_ecl(passport[:ecl]) && validate_pid(passport[:pid])
  end

  defp validate_passport(passport) do
    case passport do
      %{:byr => _, :iyr => _, :eyr => _, :hgt => _, :hcl => _, :ecl => _, :pid => _} -> true
      %{} -> false
    end
  end

  def p1 do
    input_stream()
    |> Stream.map(&String.split(&1, [" ", "\n"], trim: true))
    |> Stream.map(&gen_map/1)
    |> Stream.filter(&validate_passport/1)
    |> Enum.count()
  end

  def p2 do
    input_stream()
    |> Stream.map(&String.split(&1, [" ", "\n"], trim: true))
    |> Stream.map(&gen_map/1)
    |> Stream.filter(&validate_passport/1)
    |> Stream.filter(&validate_passport_fields/1)
    |> Enum.count()
  end
end
