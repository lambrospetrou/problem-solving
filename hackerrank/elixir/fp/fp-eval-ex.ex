defmodule Solution do
    require Integer

    def main() do
        n = getln_int()
        for _ <- 1..n do
            calc_ex(getln_float()) |> IO.puts
        end
    end

    defp calc_ex(x), do: do_calc_ex(x, 10, 0)
    defp do_calc_ex(x, 0, acc), do: acc
    defp do_calc_ex(x, cnt, acc), do: do_calc_ex(x, cnt-1, acc + :math.pow(x, cnt-1)/fact(cnt-1))

    defp fact(n), do: do_fact(1, n)
    defp do_fact(acc, 0), do: acc
    defp do_fact(acc, n), do: do_fact(acc*n, n-1)

    defp getln_ints(n), do: IO.gets("") |> String.trim |> String.split(" ", parts: n) |> Enum.map(&String.to_integer/1)
    defp getln_int(), do: IO.gets("") |> String.trim |> String.to_integer
    defp getln_float(), do: IO.gets("") |> String.trim |> String.to_float
    defp parse_int(x), do: x |> String.trim |> String.to_integer

    defp getlns_ints(), do: getlns() |> Enum.map(&parse_int/1)
    defp getlns_floats(), do: getlns() |> Enum.map(&String.to_float/1)

    defp getlns(), do: do_getlns([]) |> Enum.reverse
    defp do_getlns(acc) do
        case IO.gets("") do
            :eof -> acc
            data -> do_getlns([ (data |> String.trim) | acc])
        end
    end

end
