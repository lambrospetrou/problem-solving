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
    |> Enum.reduce(%{}, fn (x, acc) -> Map.update(acc, x, 1, &(&1 + 1)) end)
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
    |> Enum.map(&String.to_charlist/1)
    |> IO.inspect()
    |> do_part2()
  end

  def do_part2([h | t]) do
    matches = Enum.filter(t, fn id -> 
      Enum.zip(h, id)
      |> Enum.count(fn {l, r} -> l != r end)
      |> (fn diff -> diff == 1 end).()
    end)

    if Enum.empty?(matches) do
      do_part2(t)
    else
      same_chars(h, hd(matches))
    end
  end

  def same_chars(l, r) do 
    Enum.zip(l, r)
    |> Enum.filter(fn {a,b} -> a == b end)
    |> Enum.map(fn {a,_} -> a end)
    |> String.Chars.to_string()
  end
end
