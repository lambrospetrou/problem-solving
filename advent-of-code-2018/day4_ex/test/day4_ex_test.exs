defmodule Day4ExTest do
  use ExUnit.Case
  doctest Day4Ex

  test "parse_records" do
    assert Day4Ex.parse_records([
      "[1518-11-01 00:00] Guard #10 begins shift",
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:30] falls asleep",
      "[1518-11-01 00:55] wakes up",
      "[1518-11-01 23:58] Guard #99 begins shift",
      "[1518-11-02 00:40] falls asleep",
      "[1518-11-02 00:50] wakes up",
      "[1518-11-03 00:05] Guard #10 begins shift",
      "[1518-11-03 00:24] falls asleep",
      "[1518-11-03 00:29] wakes up",
      "[1518-11-04 00:02] Guard #99 begins shift",
      "[1518-11-04 00:36] falls asleep",
      "[1518-11-04 00:46] wakes up",
      "[1518-11-05 00:03] Guard #99 begins shift",
      "[1518-11-05 00:45] falls asleep",
      "[1518-11-05 00:55] wakes up"
    ]) == %{
      "10" => %{sleep_time: [24..28, 30..54, 5..24]},
      "99" => %{sleep_time: [45..54, 36..45, 40..49]}
    }
  end

  test "max_guard" do
    assert Day4Ex.max_guard(%{
      "10" => %{sleep_time: [24..28, 30..54, 5..24]},
      "99" => %{sleep_time: [45..54, 36..45, 40..49]}
    }) == {"10", 50}
  end

  test "max_minute" do
    assert Day4Ex.max_minute([1..3, 3..5, 1..5]) == {3, 3}
    assert Day4Ex.max_minute([24..28, 30..54, 5..24]) == {24, 2}
  end

  test "max_minutes" do
    assert Day4Ex.max_minutes(%{
      "10" => %{sleep_time: [24..28, 30..54, 5..24]},
      "99" => %{sleep_time: [45..54, 36..45, 40..49]}
    }) == {"99", 45, 3}
  end
end
