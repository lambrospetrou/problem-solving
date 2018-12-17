defmodule Day9Ex do
  alias __MODULE__.CircularList

  @doc """
      iex> Day9Ex.parse_input("470 players; last marble is worth 72170 points")
      {470, 72170}
  """
  def parse_input(line) do
    [players, points] =
      line
      |> String.splitter([" players; last marble is worth ", " points"], trim: true)
      |> Enum.take(2)
      |> Enum.map(&String.to_integer/1)
    {players, points}
  end

  @doc """
      iex> Day9Ex.parse_input("9 players; last marble is worth 25 points") |> Day9Ex.high_score()
      32

      iex> Day9Ex.parse_input("10 players; last marble is worth 1618 points") |> Day9Ex.high_score()
      8317

      iex> Day9Ex.parse_input("13 players; last marble is worth 7999 points") |> Day9Ex.high_score()
      146373

      iex> Day9Ex.parse_input("17 players; last marble is worth 1104 points") |> Day9Ex.high_score()
      2764

      iex> Day9Ex.parse_input("21 players; last marble is worth 6111 points") |> Day9Ex.high_score()
      54718

      iex> Day9Ex.parse_input("30 players; last marble is worth 5807 points") |> Day9Ex.high_score()
      37305
  """
  def high_score({players_count, max_points}) do
    next_player = fn player -> rem(player, players_count) + 1 end

    {_, score} =
      do_high_score(
        1,
        max_points,
        1,
        next_player,
        CircularList.new([0]),
        %{})

    score
    |> Map.values()
    |> Enum.max()
  end

  def do_high_score(next, max_next, _, _, marbles, score) when next == max_next+1 do
    {marbles, score}
  end
  def do_high_score(next, max_next, player, next_player, marbles, score) when rem(next, 23) == 0 do
    # Remove the `7th` marble counter clockwise and assign `current` to the 6th counter clockwise

    marbles = Enum.reduce(1..7, marbles, fn _, marbles ->
      CircularList.counter_clockwise(marbles)
    end)
    {to_be_removed, marbles} = CircularList.pop_clockwise(marbles)
    score = Map.update(score, player, next + to_be_removed, &(&1 + next + to_be_removed))

    do_high_score(next+1, max_next, next_player.(player), next_player, marbles, score)
  end

  def do_high_score(next, max_next, player, next_player, marbles, score) do
    # Insert `next` after one marble clockwise
    marbles =
      marbles
      |> CircularList.clockwise()
      |> CircularList.insert(next)

    do_high_score(next+1, max_next, next_player.(player), next_player, marbles, score)
  end

  defmodule CircularList do
    def new(c_clw), do: {c_clw, []}

    def counter_clockwise({[current], clw}), do: {Enum.reverse(clw), [current]}
    def counter_clockwise({[current | c_clw], clw}), do: {c_clw, [current | clw]}

    def clockwise({c_clw, []}), do: clockwise({[], Enum.reverse(c_clw)})
    def clockwise({c_clw, [next | clw]}), do: {[next | c_clw], clw}

    def pop_clockwise({[popped | c_clw], clw}), do: {popped, clockwise({c_clw, clw})}
    def insert({c_clw, clw}, inserted), do: {[inserted | c_clw], clw}
  end

  @doc """
      iex> Day9Ex.part1()
      388024
  """
  def part1() do
    parse_input("470 players; last marble is worth 72170 points")
    |> high_score()
  end

  @doc """
      iex> Day9Ex.part2()
      3180929875
  """
  def part2() do
    parse_input("470 players; last marble is worth 7217000 points")
    |> high_score()
  end
end
