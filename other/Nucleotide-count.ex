defmodule Nucleotide do

    # http://exercism.io/exercises/elixir/nucleotide-count/readme

    def solve() do
        str = IO.gets("") |> String.trim
       
        res = count(str, %{?a => 0, ?c => 0, ?g => 0, ?t => 0})

        Enum.each(String.to_charlist("acgt"), fn ch -> IO.puts ("#{<<ch>>} : #{res[ch]}") end)
    end

    defp count(<<>>, res), do: res
    defp count(<<h::utf8, t::binary>>, res) when h == ?a or h == ?c or h == ?g or h == ?t, do: count(t, %{res | h => res[h] + 1})
    defp count(<<_h::utf8, t::binary>>, res), do: count(t, res)

end

Nucleotide.solve()
