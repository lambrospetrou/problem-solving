defmodule AoC.Day1 do
  def get_freqs(input) do
    File.read!(input)
    |> String.split("\n", trim: true) 
    |> Enum.map(&String.to_integer/1)
  end

  def part1(input \\ "day1-input.txt") do
    get_freqs(input) 
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end

  def part2(input \\ "day1-input.txt") do
    get_freqs(input) 
    |> Stream.cycle()
    |> do_part2()
  end

  def do_part2(freqs) do
    Enum.reduce_while(freqs, {0, MapSet.new() |> MapSet.put(0)}, fn new_freq, {acc, seen} -> 
      new_acc = acc + new_freq
      case MapSet.member?(seen, new_acc) do
        true -> {:halt, new_acc}
        _ -> {:cont, {new_acc, MapSet.put(seen, new_acc)}}
      end
    end)
  end
end
