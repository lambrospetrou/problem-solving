defmodule Solution do
    # https://www.hackerrank.com/challenges/fp-solve-me-first

    def main() do
        IO.puts getln_int() + getln_int()
    end

    defp getln_ints(n), do: IO.gets("") |> String.trim |> String.split(" ", parts: n) |> Enum.map(&String.to_integer/1)
    defp getln_int, do: IO.gets("") |> String.trim |> String.to_integer
end
