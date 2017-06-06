defmodule Solution do

    def main() do
        x = getln_int()
        arr = getlns_ints()
        loop(x, [], arr) |> Enum.reverse |> Enum.each(fn x -> IO.puts x end)
    end

    defp loop(_, acc, []), do: acc
    defp loop(x, acc, [h | t]) do
        case h < x do
            true -> loop(x, [h | acc], t)
            _ -> loop(x, acc, t)
        end
    end

    defp getln_ints(n), do: IO.gets("") |> String.trim |> String.split(" ", parts: n) |> Enum.map(&String.to_integer/1)
    defp getln_int(), do: IO.gets("") |> String.trim |> String.to_integer
    defp parse_int(x), do: x |> String.trim |> String.to_integer

    defp getlns_ints(), do: getlns() |> Enum.map(&parse_int/1)

    defp getlns(), do: do_getlns([]) |> Enum.reverse
    defp do_getlns(acc) do
        case IO.gets("") do
            :eof -> acc
            data -> do_getlns([ (data |> String.trim) | acc])
        end
    end

end
