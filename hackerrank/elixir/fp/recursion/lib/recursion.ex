defmodule Recursion.Gcd do
  def main() do
    [x, y] = IO.gets("") |> String.trim |> String.split(" ", parts: 2) |> Enum.map(&String.to_integer/1)
    gcd(x, y) |> IO.puts
  end

  def gcd(x, 0), do: x
  def gcd(x, y) do
    gcd(y, Integer.mod(x, y))
  end
end

defmodule Recursion do
  @moduledoc """
  Documentation for Recursion.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Recursion.hello
      :world

  """
  def hello do
    :world
  end
end
