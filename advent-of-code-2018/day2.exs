defmodule AoC.Day2 do
  def get_input(input) do
    File.read!(input)
    |> String.split("\n", trim: true)
  end

  def part1(input \\ "day2-input.txt") do
    get_input(input) 
    |> Enum.map(&handle_id/1)
    |> Enum.reduce({0, 0}, fn ({two, three}, {two_acc, three_acc}) -> {two_acc + two, three_acc + three} end)
    |> (fn ({twos, threes})-> twos * threes end).()
  end

  def handle_id(id) do
    id
    |> String.to_charlist()
    |> Enum.reduce(%{}, fn (x, acc) ->
      {_, new_acc} = Map.get_and_update(acc, x, fn current_x -> 
        if current_x == nil do
          {current_x, 1}
        else
          {current_x, current_x + 1}
        end
      end)
      new_acc
    end)
    |> Map.values()
    |> Enum.filter(&(&1 == 2 || &1 == 3))
    |> Enum.sort() |> Enum.uniq()
    |> (fn 
      ([2, 3]) -> {1, 1}
      ([2]) -> {1, 0}
      ([3]) -> {0, 1}
      _ -> {0, 0}
    end).()
  end

  def part2(input \\ "day2-input.txt") do
    get_input(input) 
    |> do_part2()
  end

  def do_part2([h | t]) do
    matches = Enum.filter(t, fn id -> 
      Enum.zip(String.to_charlist(h), String.to_charlist(id))
      |> Enum.reduce(0, fn ({l, r}, acc) -> if l == r do acc else acc + 1 end end)
      |> (fn diff -> if diff == 1 do true else false end end).()
    end)

    if Enum.empty?(matches) do
      do_part2(t)
    else
      same_chars(h, hd(matches))
    end
  end

  def same_chars(l, r) do 
    Enum.zip(String.to_charlist(l), String.to_charlist(r))
    |> Enum.filter(fn {a,b} -> a == b end)
    |> Enum.map(fn {a,_} -> a end)
    |> String.Chars.to_string()
  end
end
