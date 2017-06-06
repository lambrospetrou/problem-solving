defmodule Solution do
    # https://www.hackerrank.com/challenges/maximum-draws

    def main() do
        t = IO.gets("") |> String.trim |> String.to_integer
        for _ <- 1..t do
            n = IO.gets("") |> String.trim |> String.to_integer
            IO.puts (n + 1)
        end
    end
end
