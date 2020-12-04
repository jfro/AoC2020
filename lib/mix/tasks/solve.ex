defmodule Mix.Tasks.Solve do
  use Mix.Task

  def run(args) do
    {year, day, bench, part} = args |> parse_args()
    part_fn = String.to_atom("p#{part}")

    run = fn ->
      apply(String.to_existing_atom("Elixir.Y#{year}.D#{day}"), part_fn, [])
    end

    # result = IO.puts("Result: #{result}")

    if bench,
      do: Benchee.run(%{part_1: run}),
      else:
        run.()
        |> IO.inspect(label: "#{year} Day #{day} Part #{part} Results")
  end

  defp parse_args(args) do
    {kw, _, _} =
      OptionParser.parse(
        args,
        aliases: [y: :year, d: :day, b: :bench, p: :part],
        strict: [year: :integer, day: :integer, bench: :boolean, part: :integer]
      )

    year = AOC.Helpers.year()
    day = AOC.Helpers.day()

    {kw[:year] || year, kw[:day] || day, kw[:bench] || false, kw[:part] || 1}
  end
end
