defmodule Day10Ex do
  @doc """
      iex> Day10Ex.parse_line("position=< 9,  1> velocity=< 0,  2>")
      {9,1,0,2}

      iex> Day10Ex.parse_line("position=<-6, 10> velocity=< 2, -2>")
      {-6,10,2,-2}
  """
  def parse_line(line) do
    [x, y, vx, vy] =
      line
      |> String.splitter(["position=<", ",", "> velocity=<", ">"], trim: true)
      |> Enum.take(4)
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)

    {x, y, vx, vy}
  end

  def parse_points(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  @doc """
      iex> Day10Ex.parse_points(\"""
      ...> position=< 9,  1> velocity=< 0,  2>
      ...> position=< 7,  0> velocity=<-1,  0>
      ...> position=< 3, -2> velocity=<-1,  1>
      ...> position=< 6, 10> velocity=<-2, -1>
      ...> position=< 2, -4> velocity=< 2,  2>
      ...> position=<-6, 10> velocity=< 2, -2>
      ...> position=< 1,  8> velocity=< 1, -1>
      ...> position=< 1,  7> velocity=< 1,  0>
      ...> position=<-3, 11> velocity=< 1, -2>
      ...> position=< 7,  6> velocity=<-1, -1>
      ...> position=<-2,  3> velocity=< 1,  0>
      ...> position=<-4,  3> velocity=< 2,  0>
      ...> position=<10, -3> velocity=<-1,  1>
      ...> position=< 5, 11> velocity=< 1, -2>
      ...> position=< 4,  7> velocity=< 0, -1>
      ...> position=< 8, -2> velocity=< 0,  1>
      ...> position=<15,  0> velocity=<-2,  0>
      ...> position=< 1,  6> velocity=< 1,  0>
      ...> position=< 8,  9> velocity=< 0, -1>
      ...> position=< 3,  3> velocity=<-1,  1>
      ...> position=< 0,  5> velocity=< 0, -1>
      ...> position=<-2,  2> velocity=< 2,  0>
      ...> position=< 5, -2> velocity=< 1,  2>
      ...> position=< 1,  4> velocity=< 2,  1>
      ...> position=<-2,  7> velocity=< 2, -2>
      ...> position=< 3,  6> velocity=<-1, -1>
      ...> position=< 5,  0> velocity=< 1,  0>
      ...> position=<-6,  0> velocity=< 2,  0>
      ...> position=< 5,  9> velocity=< 1, -2>
      ...> position=<14,  7> velocity=<-2,  0>
      ...> position=<-3,  6> velocity=< 2, -1>
      ...> \""") |> Day10Ex.gen_map() |> Day10Ex.map_to_charlist() |> List.to_string()
      \"""
      ........#.............
      ................#.....
      .........#.#..#.......
      ......................
      #..........#.#.......#
      ...............#......
      ....#.................
      ..#.#....#............
      .......#..............
      ......#...............
      ...#...#.#...#........
      ....#..#..#.........#.
      .......#..............
      ...........#..#.......
      #...........#.........
      ...#.......#..........
      \"""
  """
  def map_to_charlist(
        {map, %{:min_x => min_x, :max_x => max_x, :min_y => min_y, :max_y => max_y}}
      ) do
    Enum.reduce(min_y..max_y, [], fn y, acc ->
      line =
        Enum.reduce(min_x..max_x, acc, fn x, acc ->
          if Map.has_key?(map, {x, y}) do
            [?# | acc]
          else
            [?. | acc]
          end
        end)

      [?\n | line]
    end)
    |> Enum.reverse()
  end

  def print_map({map, %{:min_x => min_x, :max_x => max_x, :min_y => min_y, :max_y => max_y}}) do
    Enum.each(min_y..max_y, fn y ->
      Enum.each(min_x..max_x, fn x ->
        if Map.has_key?(map, {x, y}) do
          IO.write('#')
        else
          IO.write('.')
        end
      end)

      IO.write('\n')
    end)

    IO.write('\n')
  end

  def gen_map(points) do
    Enum.reduce(points, {%{}, %{}}, fn point, acc ->
      put_point(acc, point)
    end)
  end

  @doc """
      iex> Day10Ex.parse_points(\"""
      ...> position=< 9,  1> velocity=< 0,  2>
      ...> position=< 7,  0> velocity=<-1,  0>
      ...> position=< 3, -2> velocity=<-1,  1>
      ...> position=< 6, 10> velocity=<-2, -1>
      ...> position=< 2, -4> velocity=< 2,  2>
      ...> position=<-6, 10> velocity=< 2, -2>
      ...> position=< 1,  8> velocity=< 1, -1>
      ...> position=< 1,  7> velocity=< 1,  0>
      ...> position=<-3, 11> velocity=< 1, -2>
      ...> position=< 7,  6> velocity=<-1, -1>
      ...> position=<-2,  3> velocity=< 1,  0>
      ...> position=<-4,  3> velocity=< 2,  0>
      ...> position=<10, -3> velocity=<-1,  1>
      ...> position=< 5, 11> velocity=< 1, -2>
      ...> position=< 4,  7> velocity=< 0, -1>
      ...> position=< 8, -2> velocity=< 0,  1>
      ...> position=<15,  0> velocity=<-2,  0>
      ...> position=< 1,  6> velocity=< 1,  0>
      ...> position=< 8,  9> velocity=< 0, -1>
      ...> position=< 3,  3> velocity=<-1,  1>
      ...> position=< 0,  5> velocity=< 0, -1>
      ...> position=<-2,  2> velocity=< 2,  0>
      ...> position=< 5, -2> velocity=< 1,  2>
      ...> position=< 1,  4> velocity=< 2,  1>
      ...> position=<-2,  7> velocity=< 2, -2>
      ...> position=< 3,  6> velocity=<-1, -1>
      ...> position=< 5,  0> velocity=< 1,  0>
      ...> position=<-6,  0> velocity=< 2,  0>
      ...> position=< 5,  9> velocity=< 1, -2>
      ...> position=<14,  7> velocity=<-2,  0>
      ...> position=<-3,  6> velocity=< 2, -1>
      ...> \""") |> Day10Ex.gen_map() |> Day10Ex.move_points() |> Day10Ex.map_to_charlist() |> List.to_string()
      \"""
      ........#....#....
      ......#.....#.....
      #.........#......#
      ..................
      ....#.............
      ..##.........#....
      ....#.#...........
      ...##.##..#.......
      ......#.#.........
      ......#...#.....#.
      #...........#.....
      ..#.....#.#.......
      \"""
  """
  def move_points({map, _dim}) do
    Enum.reduce(map, {%{}, %{}}, fn {{x, y}, points}, acc ->
      Enum.reduce(points, acc, fn {vx, vy}, acc ->
        put_point(acc, {x + vx, y + vy, vx, vy})
      end)
    end)
  end

  @doc """
      iex> Day10Ex.parse_points(\"""
      ...> position=< 9,  1> velocity=< 0,  2>
      ...> position=< 7,  0> velocity=<-1,  0>
      ...> position=< 3, -2> velocity=<-1,  1>
      ...> position=< 6, 10> velocity=<-2, -1>
      ...> position=< 2, -4> velocity=< 2,  2>
      ...> position=<-6, 10> velocity=< 2, -2>
      ...> position=< 1,  8> velocity=< 1, -1>
      ...> position=< 1,  7> velocity=< 1,  0>
      ...> position=<-3, 11> velocity=< 1, -2>
      ...> position=< 7,  6> velocity=<-1, -1>
      ...> position=<-2,  3> velocity=< 1,  0>
      ...> position=<-4,  3> velocity=< 2,  0>
      ...> position=<10, -3> velocity=<-1,  1>
      ...> position=< 5, 11> velocity=< 1, -2>
      ...> position=< 4,  7> velocity=< 0, -1>
      ...> position=< 8, -2> velocity=< 0,  1>
      ...> position=<15,  0> velocity=<-2,  0>
      ...> position=< 1,  6> velocity=< 1,  0>
      ...> position=< 8,  9> velocity=< 0, -1>
      ...> position=< 3,  3> velocity=<-1,  1>
      ...> position=< 0,  5> velocity=< 0, -1>
      ...> position=<-2,  2> velocity=< 2,  0>
      ...> position=< 5, -2> velocity=< 1,  2>
      ...> position=< 1,  4> velocity=< 2,  1>
      ...> position=<-2,  7> velocity=< 2, -2>
      ...> position=< 3,  6> velocity=<-1, -1>
      ...> position=< 5,  0> velocity=< 1,  0>
      ...> position=<-6,  0> velocity=< 2,  0>
      ...> position=< 5,  9> velocity=< 1, -2>
      ...> position=<14,  7> velocity=<-2,  0>
      ...> position=<-3,  6> velocity=< 2, -1>
      ...> \""") |> Day10Ex.gen_map() |> Day10Ex.move_points_times(4) |> Day10Ex.map_to_charlist() |> List.to_string()
      \"""
      ........#....
      ....##...#.#.
      ..#.....#..#.
      .#..##.##.#..
      ...##.#....#.
      .......#....#
      ..........#..
      #......#...#.
      .#.....##....
      ...........#.
      ...........#.
      \"""
  """
  def move_points_times(map_with_dim, times) do
    Enum.reduce(1..times, map_with_dim, fn _iteration, acc ->
      acc = move_points(acc)

      # Helps find which iteration has the text clearly shown (less width and height)
      # IO.puts(
      #   "#{elem(acc, 1)[:max_x] - elem(acc, 1)[:min_x]} #{
      #     elem(acc, 1)[:max_y] - elem(acc, 1)[:min_y]
      #   } #{iteration}"
      # )

      acc
    end)
  end

  defp put_point({map, dim}, {x, y, vx, vy}) do
    {
      Map.update(map, {x, y}, [{vx, vy}], fn existing -> [{vx, vy} | existing] end),
      dim
      |> Map.update(:min_x, x, fn current -> min(x, current) end)
      |> Map.update(:max_x, x, fn current -> max(x, current) end)
      |> Map.update(:min_y, y, fn current -> min(y, current) end)
      |> Map.update(:max_y, y, fn current -> max(y, current) end)
    }
  end

  @doc """
      iex> Day10Ex.part1()
      \"""
      #####...######...####...#.......#####...#....#..######..######
      #....#..#.......#....#..#.......#....#..##...#.......#..#.....
      #....#..#.......#.......#.......#....#..##...#.......#..#.....
      #....#..#.......#.......#.......#....#..#.#..#......#...#.....
      #####...#####...#.......#.......#####...#.#..#.....#....#####.
      #..#....#.......#.......#.......#..#....#..#.#....#.....#.....
      #...#...#.......#.......#.......#...#...#..#.#...#......#.....
      #...#...#.......#.......#.......#...#...#...##..#.......#.....
      #....#..#.......#....#..#.......#....#..#...##..#.......#.....
      #....#..######...####...######..#....#..#....#..######..######
      \"""
  """
  def part1(times \\ 10007) do
    File.read!("day10-input.txt")
    |> parse_points()
    |> gen_map()
    |> move_points_times(times)
    |> map_to_charlist()
    |> List.to_string()

    # |> print_map()
  end
end
