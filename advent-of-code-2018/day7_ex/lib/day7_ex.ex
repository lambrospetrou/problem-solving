defmodule Day7Ex do
  @doc """
      iex> Day7Ex.parse_instructions("
      ...> Step C must be finished before step A can begin.
      ...> Step C must be finished before step F can begin.
      ...> Step A must be finished before step B can begin.
      ...> Step A must be finished before step D can begin.
      ...> Step B must be finished before step E can begin.
      ...> Step D must be finished before step E can begin.
      ...> Step F must be finished before step E can begin.
      ...> ")
      %{
        ?C => [?F, ?A],
        ?A => [?D, ?B],
        ?B => [?E],
        ?D => [?E],
        ?F => [?E]
      }
  """
  def parse_instructions(string) do
    string
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn line -> byte_size(line) > 0 end)
    |> Enum.map(&parse_instruction/1)
    |> Enum.reduce(%{}, fn {from, to}, acc -> Map.update(acc, from, [to], &([to | &1])) end)
  end

  def parse_instruction(<<"Step ", from::utf8, " must be finished before step ", to::utf8, _::binary>>) do
    {from, to}
  end

  @doc """
      iex> Day7Ex.prepare_instructions(%{
      ...> ?C => [?F, ?A],
      ...> ?A => [?D, ?B],
      ...> ?B => [?E],
      ...> ?D => [?E],
      ...> ?F => [?E]
      ...> })
      {
        %{
          ?C => [?F, ?A],
          ?A => [?D, ?B],
          ?B => [?E],
          ?D => [?E],
          ?F => [?E]
        },
        [?C],
        %{
          ?A => 1,
          ?F => 1,
          ?B => 1,
          ?D => 1,
          ?E => 3
        }
      }
  """
  def prepare_instructions(instructions) do
    not_ready =
      instructions
      |> Enum.reduce(%{}, fn {_, list_of_to}, acc ->
        Enum.reduce(list_of_to, acc, fn to, acc ->
          Map.update(acc, to, 1, &(&1 + 1))
        end)
      end)

    ready =
      instructions
      |> Enum.reduce(MapSet.new(), fn {from, _}, acc ->
        if Map.has_key?(not_ready, from) do
          acc
        else
          MapSet.put(acc, from)
        end
      end)
      |> MapSet.to_list()
      |> Enum.sort()

    {instructions, ready, not_ready}
  end

  @doc """
      iex> Day7Ex.parse_instructions("
      ...> Step C must be finished before step A can begin.
      ...> Step C must be finished before step F can begin.
      ...> Step A must be finished before step B can begin.
      ...> Step A must be finished before step D can begin.
      ...> Step B must be finished before step E can begin.
      ...> Step D must be finished before step E can begin.
      ...> Step F must be finished before step E can begin.
      ...> ") |> Day7Ex.prepare_instructions() |> Day7Ex.process_instructions()
      [?C, ?A, ?B, ?D, ?F, ?E]
  """
  def process_instructions({instructions, ready, not_ready}) do
    process_instructions(instructions, ready, not_ready, [])
  end
  def process_instructions(_instructions, [], %{}, result) do
    result |> Enum.reverse()
  end
  def process_instructions(instructions, [next | ready], not_ready, result) do
    {not_ready, ready} =
      Map.get(instructions, next, [])
      |> Enum.reduce({not_ready, ready}, fn to, {not_ready, ready} ->
        {x, not_ready} =
          Map.get_and_update(not_ready, to, fn remaining ->
            if remaining == 1 do
              :pop
            else
              {remaining, remaining - 1}
            end
          end)
        {not_ready, if x == 1 do [to | ready] else ready end}
      end)

    process_instructions(instructions, ready |> Enum.sort(), not_ready, [next | result])
  end

  def part1(input \\ "day7-input.txt") do
    File.read!(input)
    |> parse_instructions()
    |> prepare_instructions()
    |> process_instructions()
  end

end
