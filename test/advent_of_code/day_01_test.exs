defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  # @tag :skip
  test "part1" do
    input = File.stream!("data/day01p1.txt")
    result = part1(input)

    assert result == 1_015_476
  end

  # @tag :skip
  test "part2" do
    input = File.stream!("data/day01p1.txt")
    result = part2(input)

    assert result == 200_878_544
  end
end
