defmodule Solution do
    # https://www.hackerrank.com/challenges/fp-hello-world-n-times

    def main() do
        n = getln_int()
        for _ <- 1..n do
            IO.puts "Hello World"
        end
    end

    defp getln_ints(n), do: IO.gets("") |> String.trim |> String.split(" ", parts: n) |> Enum.map(&String.to_integer/1)
    defp getln_int, do: IO.gets("") |> String.trim |> String.to_integer
end
