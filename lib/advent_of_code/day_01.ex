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

  def part1(args) do
    stream1 = args |> Stream.map(&String.trim(&1)) |> Stream.map(&String.to_integer(&1))
    stream2 = stream1

    result =
      stream1
      |> Enum.with_index()
      |> Stream.map(&find_pair(&1, stream2))
      |> Enum.filter(fn x -> x != nil end)
      |> Enum.at(0)

    elem(result, 0)
  end

  def part2(args) do
  end
end
