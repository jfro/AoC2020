defmodule AdventOfCode.Day01 do
  def find_pair(value, stream) do
    num = elem(value, 0)

    result =
      stream
      |> Enum.drop(elem(value, 1) + 1)
      |> Stream.map(fn x -> {x * num, x + num} end)
      |> Enum.filter(fn x -> elem(x, 1) == 2020 end)
      # |> Enum.map_reduce(0, fn x, acc -> {x * 2, x + acc} end)
      |> Enum.at(0)

    result
  end

  def num_stream(stream) do
    stream |> Stream.map(&String.trim/1) |> Stream.map(&String.to_integer/1)
  end

  def part1(args) do
    list = num_stream(args) |> Enum.to_list()

    case find_submatch(list, 2020) do
      {first, second} -> first * second
      :none -> {:error, "No result found"}
    end
  end

  def find_submatch([first | rest], target) do
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

  def find_match([first | rest]) do
    target = 2020 - first

    case find_submatch(rest, target) do
      {second, third} -> {first, second, third}
      :none -> find_match(rest)
    end
  end

  def part2(args) do
    stream = num_stream(args)
    {x, y, z} = stream |> Enum.to_list() |> find_match()
    x * y * z
  end
end
