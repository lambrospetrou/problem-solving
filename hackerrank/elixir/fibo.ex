defmodule Solution do
   
    def main() do
        t = IO.gets("") |> String.trim |> String.to_integer
        for _ <- 1..t do
            n = IO.gets("") |> String.trim |> String.to_integer
            if is_fib(n) do
                IO.puts "IsFibo"
            else 
                IO.puts "IsNotFibo"
            end
        end
    end

    def is_fib(0), do: true
    def is_fib(1), do: true
    def is_fib(2), do: true
    def is_fib(3), do: true
    def is_fib(5), do: true
    def is_fib(8), do: true
    def is_fib(x) do
        mult = 5*x*x
        isPerfectSquare(mult + 4) or isPerfectSquare(mult - 4)
    end

    defp isPerfectSquare(x) do 
        root = Kernel.round(:math.sqrt(x))
        root*root == x
    end

end
