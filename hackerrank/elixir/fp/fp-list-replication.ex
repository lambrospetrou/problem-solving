defmodule Solution do

    def main() do
        n = getln_int()
        loop(n, []) |> Enum.reverse |> IO.puts
    end

    defp loop(n, acc) do
        data = IO.gets("")
        case data do
            :eof -> acc
            _ ->
                elems = for _ <- 1..n, do: (data |> String.trim) <> "\n"
                loop(n, elems ++ acc)
        end
    end

    defp getln_ints(n), do: IO.gets("") |> String.trim |> String.split(" ", parts: n) |> Enum.map(&String.to_integer/1)
    defp getln_int, do: IO.gets("") |> String.trim |> String.to_integer
    defp parse_int(x), do: x |> String.trim |> String.to_integer
end
