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
      iex> Day9Ex.high_score({9, 25})
      32

      iex> Day9Ex.high_score({10, 1618})
      8317

      iex> Day9Ex.high_score({13, 7999})
      146373

      iex> Day9Ex.high_score({17, 1104})
      2764

      iex> Day9Ex.high_score({21, 6111})
      54718

      iex> Day9Ex.high_score({30, 5807})
      37305
  """
  def high_score({players_count, max_points}) do
    next_player = fn player -> rem(player, players_count) + 1 end

    initial_acc = {
      1,
      CircularList.new([0]),
      %{}
    }

    {_, _, score} =
      Enum.reduce(1..max_points, initial_acc, fn next, {player, marbles, score} ->
        {marbles, score} = next_move(next, player, marbles, score)
        {next_player.(player), marbles, score}
      end)

    score
    |> Map.values()
    |> Enum.max()
  end

  def next_move(next, player, marbles, score) when rem(next, 23) == 0 do
    # Remove the `7th` marble counter clockwise and assign `current` to the 6th counter clockwise
    marbles =
      Enum.reduce(1..7, marbles, fn _, marbles ->
        CircularList.counter_clockwise(marbles)
      end)

    {to_be_removed, marbles} = CircularList.pop_clockwise(marbles)
    score = Map.update(score, player, next + to_be_removed, &(&1 + next + to_be_removed))

    {marbles, score}
  end

  def next_move(next, _player, marbles, score) do
    # Insert `next` after one marble clockwise
    marbles =
      marbles
      |> CircularList.clockwise()
      |> CircularList.insert(next)

    {marbles, score}
  end

  defmodule CircularList do
    @moduledoc """
    This circular list manages a tuple with two lists where they are of the form:

    { [current | counter_clockwise_elements], [clockwise_elements] }
    """

    def new([_at_least_one | _rest] = c_clw), do: {c_clw, []}

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
