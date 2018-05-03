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

defmodule Recursion.StringMingling do
  def main() do
    a = IO.gets("") |> String.trim()
    b = IO.gets("") |> String.trim()

    mingle2(a, b) |> IO.puts()
  end

  def mingle2(a, b) do
    Enum.zip(String.to_charlist(a), String.to_charlist(b))
    |> Enum.map_join(fn {a, b} -> <<a, b>> end)
  end

  def mingle(a, b), do: do_mingle(a, b, "")

  defp do_mingle("", "", result) do
    result
  end

  defp do_mingle(<<a::utf8, rest_a::binary>>, <<b::utf8, rest_b::binary>>, result) do
    do_mingle(rest_a, rest_b, <<result::binary, a::utf8, b::utf8>>)
  end
end

defmodule Recursion.StringOPermute do
  def main() do
    n = IO.gets("") |> String.trim() |> String.to_integer()

    1..n
    |> Enum.map(fn _ -> IO.gets("") |> String.trim() end)
    |> Enum.map(&permute/1)
    |> Enum.each(&IO.puts/1)
  end

  def permute(s), do: do_permute(s, "")

  defp do_permute("", result) do
    result
  end

  defp do_permute(<<a::utf8, b::utf8, rest::binary>>, result) do
    do_permute(rest, <<result::binary, b::utf8, a::utf8>>)
  end
end

defmodule Recursion.FractalTrees do
  def main() do
    n = IO.gets("") |> String.trim() |> String.to_integer()

    generate(n, 63, 100)
    |> Enum.each(&IO.puts/1)
  end

  def generate(n, rows, columns) do
    aces(n, columns, 16)
    |> Enum.map(fn row -> generate_row(row, columns) end)
    |> populate_empty_rows(rows, columns)
  end

  def populate_empty_rows(rows_with_aces, rows, columns) do
    rows..(length(rows_with_aces) + 1)
    |> Enum.map(fn _ -> String.duplicate("_", columns) end)
    |> Enum.concat(rows_with_aces)
  end

  # Populate the underscores in each row along with the aces
  def generate_row(aces, columns) do
    do_generate_row(aces, columns, "", 0)
  end

  def do_generate_row([], columns, result, previous),
    do: <<result::binary, String.duplicate("_", columns - previous)::binary>>

  def do_generate_row([pos | rest], columns, result, previous) do
    do_generate_row(
      rest,
      columns,
      <<result::binary, String.duplicate("_", pos - previous - 1)::binary, ?1::utf8>>,
      pos
    )
  end

  # Calculate where the aces are in each row
  def aces(0, _columns, _initialStep), do: []

  def aces(n, columns, initialStep) do
    do_aces(:vertical, n, initialStep - 1, initialStep, [[div(columns, 2)]])
  end

  # everything done
  def do_aces(:vertical, 0, _, _steps, result), do: result

  def do_aces(:vertical, n, 0, steps, result) do
    do_aces(:diag_first, n, steps, steps, result)
  end

  def do_aces(:vertical, n, crow, steps, [h | _rest] = result) do
    do_aces(:vertical, n, crow - 1, steps, [h | result])
  end

  def do_aces(:diag_first, n, crow, steps, [h | _rest] = result) do
    do_aces(:diag_rest, n, crow - 1, steps, [
      Enum.flat_map(h, fn pos -> [pos - 1, pos + 1] end) | result
    ])
  end

  def do_aces(:diag_rest, n, 0, steps, result) do
    do_aces(:vertical, n - 1, div(steps, 2), div(steps, 2), result)
  end

  def do_aces(:diag_rest, n, crow, steps, [h | _rest] = result) do
    do_aces(:diag_rest, n, crow - 1, steps, [do_aces_diag(h, []) | result])
  end

  def do_aces_diag([], result), do: result

  def do_aces_diag([a, b | rest], result) do
    do_aces_diag(rest, result ++ [a - 1, b + 1])
  end
end

defmodule Recursion.StringCompression do
  def main() do
    IO.gets("")
    |> String.trim()
    |> compress()
    |> IO.puts()
  end

  def compress(<<>>), do: ""
  def compress(<<ch::utf8, rest::binary>>), do: do_compress(rest, {ch, 1}, "")

  defp do_compress(<<>>, previous, result), do: add_result(previous, result)

  defp do_compress(<<ch::utf8, rest::binary>>, {ch, x}, result),
    do: do_compress(rest, {ch, x + 1}, result)

  defp do_compress(<<ch::utf8, rest::binary>>, previous, result),
    do: do_compress(rest, {ch, 1}, add_result(previous, result))

  defp add_result({ch, 1}, result), do: <<result::binary, ch::utf8>>

  defp add_result({ch, x}, result), do: <<result::binary, ch::utf8, Integer.to_string(x)::binary>>
end

defmodule Recursion.PrefixCompression do
  def main() do
    x = IO.gets("") |> String.trim()
    y = IO.gets("") |> String.trim()

    prefix_compress(x, y)
    |> Enum.each(fn {n, str} -> IO.puts("#{n} #{str}") end)
  end

  def prefix_compress(x, y), do: do_compress(x, y, "")

  defp do_compress(<<>>, <<>>, common), do: result("", "", common)
  defp do_compress(<<>>, b, common), do: result("", b, common)
  defp do_compress(a, <<>>, common), do: result(a, "", common)

  defp do_compress(<<a::utf8, aa::binary>>, <<a::utf8, bb::binary>>, common) do
    do_compress(aa, bb, <<common::binary, a::utf8>>)
  end

  defp do_compress(a, b, common), do: result(a, b, common)

  defp result(a, b, common) do
    [{String.length(common), common}, {String.length(a), a}, {String.length(b), b}]
  end
end

defmodule Recursion.StringReduction do
  def main() do
    x = IO.gets("") |> String.trim()

    reduct(x) |> IO.puts()
  end

  def reduct(s) do
    do_reduct(s, %{}, "")
  end

  defp do_reduct(<<>>, _seen, result) do
    result
  end

  defp do_reduct(<<ch::utf8, rest::binary>>, seen, result) do
    case seen[ch] do
      nil -> do_reduct(rest, Map.put(seen, ch, 1), <<result::binary, ch::utf8>>)
      _ -> do_reduct(rest, seen, result)
    end
  end
end

defmodule Recursion.FilterElements do
  @moduledoc false

  def main() do
    t = IO.gets("") |> String.trim() |> String.to_integer()

    1..t
    |> Enum.map(fn _ ->
      [n, k] = IO.gets("") |> String.trim() |> String.split() |> Enum.map(&String.to_integer/1)
      nums = IO.gets("") |> String.trim() |> String.split() |> Enum.map(&String.to_integer/1)

      {n, k, nums}
    end)
    |> Enum.map(&execute_case/1)
    |> Enum.map(&case_output/1)
    |> Enum.each(&IO.puts/1)
  end

  def case_output([]), do: "-1"
  def case_output(result), do: Enum.join(result, " ")

  @doc """

      iex> Recursion.FilterElements.execute_case({0, 2, [1,2,3,1,2,3,1,2,3]})
      [1,2,3]

      iex> Recursion.FilterElements.execute_case({0, 2, [3,2,1,2,3]})
      [3,2]

      iex> Recursion.FilterElements.execute_case({0, 3, [5,1,2,5,3,2,5,1,1,3,3,2]})
      [5,1,2,3]

  """
  def execute_case({_, k, nums}) do
    do_aggregate(nums, %{}, 1)
    |> Enum.filter(fn {_, {_, count}} -> count >= k end)
    |> Enum.sort_by(fn {_, {idx, _}} -> idx end)
    |> Enum.map(fn {key, _} -> key end)
  end

  defp do_aggregate([], result, _), do: result

  defp do_aggregate([h | rest], result, idx) do
    {_, new_result} =
      Map.get_and_update(result, h, fn
        nil -> {nil, {idx, 1}}
        {first_idx, count} = old -> {old, {first_idx, count + 1}}
      end)

    do_aggregate(rest, new_result, idx + 1)
  end
end

defmodule Recursion do
  @moduledoc """
  Documentation for Recursion.
  """
end
