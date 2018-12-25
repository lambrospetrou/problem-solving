defmodule Day12Ex do
  @doc """
      iex> Day12Ex.part1()
      4818
  """
  def part1() do
    initial_data =
      File.read!("day12-input.txt")
      |> String.trim()
      |> String.split("\n", trim: true)
      |> parse_input()

    pots = jump_to_generation(initial_data, 20)
    sum_all_plants(pots)
  end

  @doc """
      iex> Day12Ex.part2()
      5100000001377
  """
  def part2() do
    initial_data =
      File.read!("day12-input.txt")
      |> String.trim()
      |> String.split("\n", trim: true)
      |> parse_input()

    pots = jump_to_generation(initial_data, 50_000_000_000)
    sum_all_plants(pots)
  end

  def sum_all_plants(pots) do
    Enum.reduce(pots, 0, fn {k, v}, total ->
      if v == ?# do
        total + k
      else
        total
      end
    end)
  end

  def jump_to_generation(data, target_generation) do
    {{pots, _, _}, seen} =
      Enum.reduce_while(1..target_generation, {data, %{}}, fn generation, {data, seen} ->
        next_data = next_generation(data)
        {pots, _, {left, _}} = next_data

        sum = sum_all_plants(pots)

        keys = Map.keys(pots) |> Enum.map(&(&1 - left)) |> Enum.sort()

        cycle? = Map.has_key?(seen, keys)
        {cycle_generation, cycle_sum, cycle_left} = Map.get(seen, keys, {nil, nil, nil})
        seen = Map.put_new(seen, keys, {generation, sum, left})
        # IO.inspect({cycle?, generation, cycle_generation, cycle_sum})

        if cycle? do
          diff_sum = sum - cycle_sum
          cycle_generations = generation - cycle_generation
          diff_left = left - cycle_left

          # IO.inspect(
          #   {sum, cycle_sum, diff_sum, generation, cycle_generation, cycle_generations, left,
          #    cycle_left}
          # )

          remaining = target_generation - generation
          pots = Map.put(pots, remaining * diff_sum, ?#)

          {:halt, {{pots, nil, nil}, seen}}
        else
          {:cont, {next_data, seen}}
        end
      end)

    pots
  end

  def next_generation({pots, rules, {left, right}}) do
    new_pots =
      Enum.reduce((left - 2)..(right + 2), %{}, fn pos, acc ->
        new_state = Map.get(rules, get_pots_around(pots, pos), ?.)

        if new_state == ?# do
          Map.put(acc, pos, new_state)
        else
          acc
        end
      end)

    {new_pots, rules, find_left_right_limits(new_pots)}
  end

  def get_pots_around(pots, current) do
    {
      Map.get(pots, current - 2, ?.),
      Map.get(pots, current - 1, ?.),
      Map.get(pots, current, ?.),
      Map.get(pots, current + 1, ?.),
      Map.get(pots, current + 2, ?.)
    }
  end

  @doc """
      iex> Day12Ex.parse_input([
      ...> "initial state: #..#.#",
      ...> "...## => #",
      ...> "#...# => #",
      ...> "#.#.# => .",
      ...> "..... => .",
      ...> ])
      {
        %{
          0 => ?#,
          1 => ?.,
          2 => ?.,
          3 => ?#,
          4 => ?.,
          5 => ?#
        },
        %{
          {?., ?., ?., ?#, ?#} => ?#,
          {?#, ?., ?., ?., ?#} => ?#,
          {?., ?., ?., ?., ?.} => ?.,
          {?#, ?., ?#, ?., ?#} => ?.,
        },
        {0, 5}
      }
  """
  def parse_input([pots_line | rules_lines]) do
    pots =
      pots_line
      |> String.trim_leading("initial state: ")
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {letter, index}, acc ->
        Map.put(acc, index, letter)
      end)

    rules =
      rules_lines
      |> Enum.map(fn line ->
        [from, <<to>>] = String.split(line, " => ", trim: true)

        {
          String.to_charlist(from) |> List.to_tuple(),
          to
        }
      end)
      |> Enum.reduce(%{}, &Map.put(&2, elem(&1, 0), elem(&1, 1)))

    {pots, rules, find_left_right_limits(pots)}
  end

  @doc """
      iex> Day12Ex.find_left_right_limits(%{0 => ?., -1 => ?#, 1 => ?#, 2 => ?.})
      {-1, 1}

      iex> Day12Ex.find_left_right_limits(%{0 => ?., -1 => ?., 1 => ?., 2 => ?.})
      {0, 0}
  """
  def find_left_right_limits(pots) do
    {left, right} =
      Enum.reduce(pots, {nil, nil}, fn {k, v}, {left, right} = acc ->
        # TODO Improve this
        if v == ?# do
          {
            if left == nil do
              k
            else
              min(left, k)
            end,
            if right == nil do
              k
            else
              max(right, k)
            end
          }
        else
          acc
        end
      end)

    {
      if left == nil do
        0
      else
        left
      end,
      if right == nil do
        0
      else
        right
      end
    }
  end
end
