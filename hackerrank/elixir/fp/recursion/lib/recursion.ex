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

defmodule Recursion.Fibonacci do
  def main() do
    n = IO.gets("") |> String.trim |> String.to_integer
    fib(n) |> IO.puts
  end

  def fib(1), do: 0
  def fib(2), do: 1
  def fib(n), do: fib(n-1) + fib(n-2)
end

defmodule Recursion do
  @moduledoc """
  Documentation for Recursion.
  """
end
