defmodule Day4Ex do

  def parse_records(lines) do
    lines
    |> Enum.sort(fn (<<date_a::size(136), _rest_a::binary>>, <<date_b::size(136), _rest_b::binary>>) -> date_a < date_b end)
    |> Enum.map(fn line -> 
      [_date, <<_h::size(16), ?:, m::binary>>, what, <<_hash::size(8), guard_id::binary>>] = String.splitter(line, ["[", "]", " "], trim: true) |> Enum.take(4)
      %{id: guard_id, minute: String.to_integer(m), what: what}
    end)
    |> Enum.reduce({nil, nil, %{}}, fn record, {id, m_start, acc} -> 
      case record.what do
        "Guard" -> {record.id, nil, acc}
        "falls" -> {id, record.minute, acc}
        "wakes" -> {id, nil, Map.update(acc, id, %{sleep_time: [m_start..(record.minute-1)]}, fn v -> 
          %{sleep_time: [m_start..(record.minute-1) | v.sleep_time]} 
        end)}
      end
    end)
    |> (fn {_, _, acc} -> acc end).()
  end

  def max_guard(records) do
    records
    |> Enum.reduce({nil, 0}, fn {id, %{sleep_time: times}}, {max_id, max_sum} -> 
      times
      |> Enum.reduce(0, fn r, acc -> acc + Enum.count(r) end)
      |> (fn sum -> if sum > max_sum do {id, sum} else {max_id, max_sum} end end).()
    end)
  end

  def max_minute(ranges) do
    ranges
    |> Enum.reduce(%{}, fn range, acc -> 
      Enum.reduce(range, acc, fn r, m -> Map.update(m, r, 1, &(&1 + 1)) end)
    end)
    |> Enum.reduce({nil, 0}, fn {m, total}, {max_minute, max_total} ->
      if total > max_total do
        {m, total}
      else
        {max_minute, max_total}
      end
    end)
  end

  def max_minutes(records) do
    records
    |> Enum.map(fn {id, %{sleep_time: ranges}} ->
      {m, total} = max_minute(ranges)
      {id, m, total}
    end)
    |> Enum.reduce({nil, 0, 0}, fn {id, m, total}, {max_id, max_minute, max_total} ->
      if total > max_total do
        {id, m, total}
      else
        {max_id, max_minute, max_total}
      end
    end)
  end

  def part2(input \\ "day4-input.txt") do
    records = get_input(input) |> parse_records()
    {id, minute, _} = max_minutes(records)

    minute * String.to_integer(id)
  end

  def part1(input \\ "day4-input.txt") do
    records = get_input(input) |> parse_records()
    {id, _} = records |> max_guard()
    {m, _} = records[id][:sleep_time] |> max_minute()

    m * String.to_integer(id)
  end

  def get_input(input) do
    File.read!(input)
    |> String.split("\n", trim: true)
  end
end
