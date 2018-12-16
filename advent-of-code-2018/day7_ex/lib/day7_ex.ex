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
  def process_instructions(_instructions, [], not_ready, result) when map_size(not_ready) == 0 do
    result |> Enum.reverse()
  end
  def process_instructions(instructions, [next | ready], not_ready, result) do
    {not_ready, ready} = update_ready_and_not_ready(instructions, next, not_ready, ready)
    process_instructions(instructions, ready |> Enum.sort(), not_ready, [next | result])
  end

  def update_ready_and_not_ready(instructions, next, not_ready, ready) do
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
      ...> ") |> Day7Ex.prepare_instructions() |> Day7Ex.multi_worker_process_instructions(2, 0)
      {[?C, ?A, ?B, ?F, ?D, ?E], 15}
  """
  def multi_worker_process_instructions({instructions, ready, not_ready}, workers \\ 5, extra_time \\ 60) do
    multi_worker_process_instructions(instructions, ready, not_ready, workers, extra_time)
  end
  def multi_worker_process_instructions(instructions, ready, not_ready, workers, extra_time) do
    num_of_steps = (Map.keys(not_ready) ++ ready) |> length()
    total_duration = num_of_steps * (extra_time + 26)
    tick_range = 0..total_duration

    initial_acc = {
      ready,
      not_ready,
      [],
      %{},
      tick_range.first
    }

    tick_range
    |> Enum.reduce_while(initial_acc, fn second, {ready, not_ready, result, in_progress, _} ->

      {ready, not_ready, result, in_progress} =
        Enum.reduce(in_progress, {ready, not_ready, result, in_progress},
          fn {step, time}, {ready, not_ready, result, in_progress} ->
            if time == 1 do
              # We finished a step so delete it from `in-progress`,
              # update the `not_ready` mapping and if necessary move them to `ready`
              {not_ready, ready} = update_ready_and_not_ready(instructions, step, not_ready, ready)
              {
                ready,
                not_ready,
                [step | result],
                Map.delete(in_progress, step),
              }
            else
              {ready, not_ready, result, Map.put(in_progress, step, time - 1)}
            end
          end)

      available_workers = workers - Enum.count(in_progress)

      in_progress =
        Enum.sort(ready)
        |> Enum.take(available_workers)
        |> Enum.reduce(in_progress, fn step, in_progress ->
          Map.put(in_progress, step, step - ?A + 1 + extra_time)
        end)

      ready = Enum.drop(ready, available_workers)
      acc = {ready, not_ready, result, in_progress, second}

      cond do
        Enum.empty?(ready) && Enum.empty?(not_ready) && Enum.empty?(in_progress) -> {:halt, acc}
        true -> {:cont, acc}
      end
    end)
    |> (fn {_, _, result, _, second} -> {Enum.reverse(result), second} end).()
  end

  def part1(input \\ "day7-input.txt") do
    File.read!(input)
    |> parse_instructions()
    |> prepare_instructions()
    |> process_instructions()
  end

  def part2(input \\ "day7-input.txt") do
    File.read!(input)
    |> parse_instructions()
    |> prepare_instructions()
    |> multi_worker_process_instructions()
  end


end
