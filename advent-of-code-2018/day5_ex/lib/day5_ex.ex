defmodule Day5Ex do
  @doc """

      iex> Day5Ex.count_polymers("dabAcCaCBAcCcaDA")
      10

  """
  def count_polymers(letters) do
    letters |> do_count_polymers([]) |> length()
  end

  def do_count_polymers(<<>>, prefix) do
    prefix |> Enum.reverse()
  end
  def do_count_polymers(<<a, rest::binary>>, [b | prefix]) when abs(a - b) == 32 do
    do_count_polymers(rest, prefix)
  end
  def do_count_polymers(<<a, rest::binary>>, prefix) do
    do_count_polymers(rest, [a | prefix])
  end

  @doc """

      iex> Day5Ex.minimum_polymer("dabAcCaCBAcCcaDA")
      4

  """
  def minimum_polymer(letters) do
    letters
    |> String.split("", trim: true)
    |> Enum.uniq_by(&String.upcase/1)
    |> Task.async_stream(fn x ->
      letters
      |> String.replace([String.upcase(x), String.downcase(x)], "")
      |> count_polymers()
    end, ordered: false)
    |> Stream.map(fn {:ok, res} -> res end)
    |> Enum.min()
  end


  @doc """

      iex> Day5Ex.part1()
      10888

  """
  def part1(input \\ "day5-input.txt") do
    File.read!(input)
    |> String.trim()
    |> count_polymers()
  end

  @doc """
      iex> Day5Ex.part2()
      6952
  """
  def part2(input \\ "day5-input.txt") do
    File.read!(input)
    |> String.trim()
    |> minimum_polymer()
  end
end
