defmodule Solution do
    require Integer

    def main() do
        ns = getlns_ints()
        ns |> reverse |> Enum.each(fn x -> IO.puts x end)
    end

    defp reverse(arr), do: do_reverse(arr, [])
    defp do_reverse([], acc), do: acc
    defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])

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
