import AOC

aoc 2020, 1 do
  defp num_stream() do
    input_stream() |> Stream.map(&String.trim/1) |> Stream.map(&String.to_integer/1)
  end

  defp find_submatch([first | rest], target) do
    subtarget = target - first

    cond do
      Enum.member?(rest, subtarget) ->
        {first, subtarget}

      Enum.count(rest) == 0 ->
        :none

      true ->
        find_submatch(rest, target)
    end
  end

  defp find_match([first | rest]) do
    target = 2020 - first

    case find_submatch(rest, target) do
      {second, third} -> {first, second, third}
      :none -> find_match(rest)
    end
  end

  def p1 do
    list = num_stream() |> Enum.to_list()

    case find_submatch(list, 2020) do
      {first, second} -> first * second
      :none -> {:error, "No result found"}
    end
  end

  def p2 do
    stream = num_stream()
    {x, y, z} = stream |> Enum.to_list() |> find_match()
    x * y * z
  end
end
