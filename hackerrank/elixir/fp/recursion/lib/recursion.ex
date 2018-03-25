defmodule Recursion.Gcd do
  def main() do
    [x, y] =
      IO.gets("")
      |> String.trim()
      |> String.split(" ", parts: 2)
      |> Enum.map(&String.to_integer/1)

    gcd(x, y) |> IO.puts()
  end

  def gcd(x, 0), do: x

  def gcd(x, y) do
    gcd(y, Integer.mod(x, y))
  end
end

defmodule Recursion.Fibonacci do
  def main() do
    n = IO.gets("") |> String.trim() |> String.to_integer()
    fib(n) |> IO.puts()
  end

  def fib_naive(1), do: 0
  def fib_naive(2), do: 1
  def fib_naive(n), do: fib(n - 1) + fib(n - 2)

  def fib(1), do: 0
  def fib(2), do: 1
  def fib(n), do: do_fib(n, 0, 1)
  def do_fib(3, prev_2, prev_1), do: prev_2 + prev_1
  def do_fib(n, prev_2, prev_1), do: do_fib(n - 1, prev_1, prev_1 + prev_2)
end

defmodule Recursion.Pascal do
  def main() do
    n = IO.gets("") |> String.trim() |> String.to_integer()

    triangle(n)
    |> Enum.reverse()
    |> Enum.map(fn line ->
      Enum.join(line, " ") |> IO.puts()
    end)
  end

  def triangle(1), do: [[1]]

  def triangle(n) do
    top = triangle(n - 1)
    previous = top |> List.first()

    summed =
      Enum.zip(previous, Enum.drop(previous, 1))
      |> Enum.map(fn {a, b} -> a + b end)

    row = [1 | summed ++ [1]]

    [row | top]
  end
end

defmodule Recursion.Sierpinski do
  def main() do
    n = IO.gets("") |> String.trim() |> String.to_integer()

    draw(32, 63, triangles(32, 63, n))
  end

  def draw(r, c, trs) do
    for row <- 0..(r - 1) do
      0..(c - 1)
      |> Enum.map(fn col -> draw_cell(row, col, trs) end)
      |> Enum.join("")
      |> IO.puts()
    end
  end

  def draw_cell(row, col, trs) do
    trs
    |> Enum.any?(fn tr -> inside?(row, col, tr) end)
    |> (fn ace ->
          if ace == true do
            "1"
          else
            "_"
          end
        end).()
  end

  # https://stackoverflow.com/a/2049593
  defp sign({y1, x1}, {y2, x2}, {y3, x3}) do
    (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3)
  end

  defp inside?(r, c, [{r, c}, {r, c}, {r, c}]), do: true
  defp inside?(r, c, [{x, y}, {x, y}, {x, y}]) when r != x or c != y, do: false

  defp inside?(r, c, [p1, p2, p3]) do
    sign({r, c}, p1, p2) <= 0.0 && sign({r, c}, p2, p3) <= 0.0 && sign({r, c}, p3, p1) <= 0.0
  end

  @doc """
  Returns a list of the points for each triangle: [{top}, {bottom_left}, {bottom_right}]
  """
  def triangles(r, c, 0), do: [[{0, Integer.floor_div(c, 2)}, {r - 1, 0}, {r - 1, c - 1}]]

  def triangles(r, c, n) do
    triangles(r, c, n - 1)
    |> Enum.map(&split_triangle/1)
    |> Enum.flat_map(fn x -> x end)
  end

  def split_triangle([{t_r, t_c}, {bl_r, bl_c}, {br_r, br_c}]) do
    [
      # Top triangle
      [
        {t_r, t_c},
        {t_r + div(bl_r - t_r, 2), bl_c + div(t_c - bl_c, 2) + 1},
        {t_r + div(bl_r - t_r, 2), t_c + div(br_c - t_c, 2)}
      ],
      # Bottom left triangle
      [
        {t_r + div(bl_r - t_r, 2) + 1, bl_c + div(t_c - bl_c, 2)},
        {bl_r, bl_c},
        {bl_r, t_c - 1}
      ],
      # Bottom right triangle
      [
        {t_r + div(bl_r - t_r, 2) + 1, t_c + div(br_c - t_c, 2) + 1},
        {br_r, t_c + 1},
        {br_r, br_c}
      ]
    ]
  end
end

defmodule Recursion do
  @moduledoc """
  Documentation for Recursion.
  """
end
