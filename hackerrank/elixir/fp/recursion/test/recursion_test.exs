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
end
