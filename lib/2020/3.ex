import AOC

aoc 2020, 3 do
  # def input_stream do
  #   "..##.......
  # #...#...#..
  # .#....#..#.
  # ..#.#...#.#
  # .#...##..#.
  # ..#.##.....
  # .#.#.#....#
  # .#........#
  # #.##...#...
  # #...##....#
  # .#..#...#.#" |> String.split("\n") |> Stream.map(&String.trim/1)
  # end

  defp check_tree(row, acc, slope) do
    adjusted_x = rem(acc, String.length(row))
    check = row |> String.graphemes() |> Enum.at(adjusted_x)
    {check == "#", acc + slope}
  end

  defp tree_count(slope) do
    result =
      input_stream()
      |> Enum.take_every(elem(slope, 1))
      |> Enum.map_reduce(0, fn x, acc ->
        check_tree(x, acc, elem(slope, 0))
      end)

    elem(result, 0) |> Enum.filter(fn x -> x end) |> Enum.count()
  end

  def p1 do
    slope = {3, 1}
    tree_count(slope)
  end

  def p2 do
    slopes = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    slopes |> Enum.map(&tree_count/1) |> Enum.reduce(fn x, acc -> x * acc end)
  end
end
