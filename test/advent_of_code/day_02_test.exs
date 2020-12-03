defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  test "part1" do
    input = File.stream!("data/day02p1.txt")
    result = part1(input)

    assert result == 546
  end

  test "part2" do
    input = File.stream!("data/day02p1.txt")
    result = part2(input)

    assert result == 275
  end
end
