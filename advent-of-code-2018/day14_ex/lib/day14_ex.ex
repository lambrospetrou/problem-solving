defmodule Day14Ex do
  @doc """
      iex> Day14Ex.part1()
      "5158916779"

      iex> Day14Ex.part1(5)
      "0124515891"

      iex> Day14Ex.part1(18)
      "9251071085"

      iex> Day14Ex.part1(2018)
      "5941429882"

      iex> Day14Ex.part1(157901)
      "9411137133"
  """
  def part1(after_recipes \\ 9, how_many \\ 10) do
    {_, _, recipes} =
      Enum.reduce(1..(after_recipes + how_many), next_round(), fn _, acc ->
        next_round(acc)
      end)

    recipes
    |> String.split("", trim: true)
    |> Enum.drop(after_recipes)
    |> Enum.take(how_many)
    |> Enum.map(fn <<x>> -> ?0 + x end)
    |> List.to_string()
  end

  @doc """
      iex> Day14Ex.part2("51589")
      9
      iex> Day14Ex.part2("01245")
      5
      iex> Day14Ex.part2("92510")
      18
      iex> Day14Ex.part2("59414")
      2018
      iex> Day14Ex.part2("101")
      2
      iex> Day14Ex.part2("157901")
      20317612
  """
  def part2(score_sequence \\ "157901") do
    score_sequence =
      score_sequence
      |> String.codepoints()
      |> Enum.map(fn <<x>> -> x - ?0 end)
      |> List.to_string()

    # |> IO.inspect()

    find_score_sequence_batched(score_sequence)
  end

  def find_score_sequence_batched(score_sequence) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(next_round(), fn iteration, {_, _, recipes} = state ->
      cond do
        rem(iteration, batch_size(iteration)) == 0 ->
          case :binary.match(recipes, score_sequence) do
            :nomatch -> {:cont, next_round(state)}
            {pos, _len} -> {:halt, pos}
          end

        true ->
          {:cont, next_round(state)}
      end
    end)
  end

  def batch_size(iteration) when iteration < 1_000, do: 1_000
  def batch_size(iteration) when iteration < 100_000, do: 10_000
  def batch_size(iteration) when iteration < 1_000_000, do: 100_000
  def batch_size(_), do: 1_000_000

  def next_round(), do: {0, 1, <<3, 7>>}

  def next_round({idx_a, idx_b, recipes}) do
    sum = recipe_at(recipes, idx_a) + recipe_at(recipes, idx_b)

    {new_recipes} =
      cond do
        sum >= 10 -> {<<recipes::binary, 1, sum - 10>>}
        true -> {<<recipes::binary, sum>>}
      end

    new_sz = byte_size(new_recipes)

    {
      rem(idx_a + recipe_at(recipes, idx_a) + 1, new_sz),
      rem(idx_b + recipe_at(recipes, idx_b) + 1, new_sz),
      new_recipes
    }
  end

  def recipe_at(recipes, idx), do: :binary.at(recipes, idx)
end
