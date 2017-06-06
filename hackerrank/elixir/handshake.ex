defmodule Solution do
    # https://www.hackerrank.com/challenges/handshake

    def main() do
        t = getln_int()
        for _ <- 1..t do
            n = getln_int()
            IO.puts Kernel.trunc((n-1)*n/2)
        end
    end

    defp getln_int, do: IO.gets("") |> String.trim |> String.to_integer
end
