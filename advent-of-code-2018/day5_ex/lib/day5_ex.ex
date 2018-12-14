defmodule Day5Ex do
  @doc """

      iex> Day5Ex.count_polymers(["d", "a", "b", "A", "c", "C", "a", "C", "B", "A", "c", "C", "c", "a", "D", "A"])
      10

  """
  def count_polymers(letters) do
    letters |> do_count_polymers([]) |> length
  end

  def do_count_polymers([], prefix) do
    prefix |> Enum.reverse()
  end
  def do_count_polymers([a], prefix) do
    [a | prefix] |> Enum.reverse()
  end
  def do_count_polymers([a, b | rest], prefix) do
    if polarity_conflict(a, b) do
      # restart the check from the beginning (naive)
      do_count_polymers((prefix |> Enum.reverse()) ++ rest, [])
    else
      do_count_polymers([b | rest], [a | prefix])
    end
  end

  def polarity_conflict(<<a>>, <<b>>), do: abs(a - b) == 32

  @doc """

      iex> Day5Ex.minimum_polymer(["d", "a", "b", "A", "c", "C", "a", "C", "B", "A", "c", "C", "c", "a", "D", "A"])
      4

  """
  def minimum_polymer(letters) do
    letters
    |> Enum.uniq_by(&String.upcase/1)
    |> IO.inspect()
    |> Task.async_stream(fn x ->
      letters
      |> Enum.filter(&(String.upcase(&1) != String.upcase(x)))
      |> count_polymers()
    end, ordered: false, max_concurrency: 4, timeout: 999999)
    |> Stream.map(fn {:ok, res} -> res end)
    |> Enum.min()
  end


  @doc """

      iex> Day5Ex.part1()
      10889

  """
  def part1(input \\ "day5-input.txt") do
    File.read!(input)
    |> String.split("", trim: true)
    |> count_polymers()
  end

  def part2(input \\ "day5-input.txt") do
    File.read!(input)
    |> String.split("", trim: true)
    |> Enum.filter(&(byte_size(String.trim(&1)) > 0))
    |> minimum_polymer()
  end
end
