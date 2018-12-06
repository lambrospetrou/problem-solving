defmodule Day3ExTest do
  use ExUnit.Case
  doctest Day3Ex

  test "parse claims" do
    assert Day3Ex.parse_claims([
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ]) == [
      %{id: 1, x: 1, y: 3, w: 4, h: 4},
      %{id: 2, x: 3, y: 1, w: 4, h: 4},
      %{id: 3, x: 5, y: 5, w: 2, h: 2}
    ]
  end

  test "get_map_of_claims" do
    # ..1.
    # ..3.
    # .5X2
    # ..2X
    assert Day3Ex.get_map_of_claims([
      %{id: 1, x: 3, y: 1, w: 1, h: 1},
      %{id: 2, x: 3, y: 3, w: 2, h: 2},
      %{id: 3, x: 3, y: 2, w: 1, h: 2},
      %{id: 4, x: 4, y: 4, w: 1, h: 1},
      %{id: 5, x: 2, y: 3, w: 2, h: 1}
    ]) == %{
      {3, 1} => 1,
      {3, 2} => 1,
      {2, 3} => 1,
      {3, 3} => 3,
      {4, 3} => 1,
      {3, 4} => 1,
      {4, 4} => 2
    }
  end

  test "count_two_plus" do
    # ..1.
    # ..3.
    # .5X2
    # ..2X
    assert Day3Ex.count_two_plus([
      %{id: 1, x: 3, y: 1, w: 1, h: 1},
      %{id: 2, x: 3, y: 3, w: 2, h: 2},
      %{id: 3, x: 3, y: 2, w: 1, h: 2},
      %{id: 4, x: 4, y: 4, w: 1, h: 1},
      %{id: 5, x: 2, y: 3, w: 2, h: 1}
    ]) == 2
  end

  test "no_overlap_claim" do
    # ..6.
    # ..3.
    # .5X2
    # ..2X
    assert Day3Ex.no_overlap_claim([
      %{id: 2, x: 3, y: 3, w: 2, h: 2},
      %{id: 3, x: 3, y: 2, w: 1, h: 2},
      %{id: 6, x: 3, y: 1, w: 1, h: 1},
      %{id: 4, x: 4, y: 4, w: 1, h: 1},
      %{id: 5, x: 2, y: 3, w: 2, h: 1},
    ]) == 6
  end
end
