defmodule Solution do
    # https://www.hackerrank.com/challenges/game-with-cells

    def main() do
        #t = getln_int()
        #for _ <- 1..t do
            [r, c] = getln_ints(2)
            IO.puts Kernel.round(Kernel.round(r/2) * Kernel.round(c/2))
        #end
    end

    defp getln_ints(n), do: IO.gets("") |> String.trim |> String.split(" ", parts: n) |> Enum.map(&String.to_integer/1)
    defp getln_int, do: IO.gets("") |> String.trim |> String.to_integer
end
