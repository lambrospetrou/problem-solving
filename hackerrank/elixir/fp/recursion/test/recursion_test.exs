defmodule RecursionTest do
  use ExUnit.Case
  doctest Recursion

  test "gcd" do
    assert Recursion.Gcd.gcd(1, 1) == 1
    assert Recursion.Gcd.gcd(1, 0) == 1
    assert Recursion.Gcd.gcd(10, 5) == 5
    assert Recursion.Gcd.gcd(10000, 100) == 100
    assert Recursion.Gcd.gcd(64, 16) == 16
    assert Recursion.Gcd.gcd(64, 20) == 4
  end

  test "fibonacci" do
    alias Recursion.Fibonacci
    assert Fibonacci.fib(1) == 0
    assert Fibonacci.fib(2) == 1
    assert Fibonacci.fib(3) == 1
    assert Fibonacci.fib(4) == 2
    assert Fibonacci.fib(5) == 3
    assert Fibonacci.fib(6) == 5
    assert Fibonacci.fib(7) == 8
    assert Fibonacci.fib(8) == 13
    assert Fibonacci.fib(9) == 21
    assert Fibonacci.fib(10) == 34
    assert Fibonacci.fib(11) == 55
    assert Fibonacci.fib(12) == 89
    assert Fibonacci.fib(13) == 144
    assert Fibonacci.fib(14) == 233
    assert Fibonacci.fib(15) == 377
  end

  test "pascal triangle" do
    alias Recursion.Pascal
    assert Pascal.triangle(1) == [[1]]
    assert Pascal.triangle(2) == [[1, 1], [1]]
    assert Pascal.triangle(3) == [[1, 2, 1], [1, 1], [1]]
    assert Pascal.triangle(4) == [[1, 3, 3, 1], [1, 2, 1], [1, 1], [1]]
  end

  test "Sierpinski triangle calculation" do
    alias Recursion.Sierpinski
    assert Sierpinski.triangles(32, 63, 1) == [[{0, 31}, {31, 0}, {31, 62}]]

    assert Sierpinski.triangles(32, 63, 2) == [
             [{0, 31}, {15, 16}, {15, 46}],
             [{16, 15}, {31, 0}, {31, 30}],
             [{16, 47}, {31, 32}, {31, 62}]
           ]

    assert Sierpinski.triangles(6, 11, 1) == [[{0, 5}, {5, 0}, {5, 10}]]

    assert Sierpinski.triangles(6, 11, 2) == [
             [{0, 5}, {2, 3}, {2, 7}],
             [{3, 2}, {5, 0}, {5, 4}],
             [{3, 8}, {5, 6}, {5, 10}]
           ]
  end
end
