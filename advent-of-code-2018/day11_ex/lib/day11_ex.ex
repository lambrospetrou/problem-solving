defmodule Day11Ex do
  @doc """
      iex> Day11Ex.calculate_grids(2, 8)
      {
        %{
          {1,1} => -3,
          {2,1} => -3,
          {1,2} => -2,
          {2,2} => -2
        },
        %{
          {1,1} => -3,
          {2,1} => -6,
          {1,2} => -5,
          {2,2} => -10
        }
      }
  """
  def calculate_grids(grid_size, serial) do
    grid =
      Enum.reduce(1..grid_size, %{}, fn x, acc ->
        Enum.reduce(1..grid_size, acc, fn y, acc ->
          Map.put(acc, {x, y}, calculate_cell_power(x, y, serial))
        end)
      end)

    summed_grid = summed_grid(grid, grid_size)

    {grid, summed_grid}
  end

  @doc """
      iex> Day11Ex.calculate_cell_power(122, 79, 57)
      -5

      iex> Day11Ex.calculate_cell_power(217, 196, 39)
      0

      iex> Day11Ex.calculate_cell_power(101, 153, 71)
      4
  """
  def calculate_cell_power(x, y, serial) do
    rack_id = x + 10
    power = (rack_id * y + serial) * rack_id
    power = rem(div(power, 100), 10)
    power - 5
  end

  def summed_grid(grid, grid_size) do
    # https://en.wikipedia.org/wiki/Summed-area_table
    Enum.reduce(1..grid_size, %{}, fn x, acc ->
      Enum.reduce(1..grid_size, acc, fn y, acc ->
        coord = {x, y}
        Map.put(acc, coord, calculate_summed_area_cell(grid, acc, coord))
      end)
    end)
  end

  defp calculate_summed_area_cell(grid, summed_grid, {x, y} = coord) do
    Map.get(grid, coord) + Map.get(summed_grid, {x, y - 1}, 0) +
      Map.get(summed_grid, {x - 1, y}, 0) - Map.get(summed_grid, {x - 1, y - 1}, 0)
  end

  def calculate_square_power(summed_grid, x, y, square_size) do
    # https://en.wikipedia.org/wiki/File:Summed_area_table.png
    a = Map.get(summed_grid, {x - 1, y - 1}, 0)
    b = Map.get(summed_grid, {x + square_size - 1, y - 1}, 0)
    c = Map.get(summed_grid, {x - 1, y + square_size - 1}, 0)
    d = Map.get(summed_grid, {x + square_size - 1, y + square_size - 1}, 0)

    a + d - b - c
  end

  @doc """
      iex> Day11Ex.calculate_grids(300, 18) |> Day11Ex.calculate_grids_max_square_power(300, 3)
      {{33,45}, 29}

      iex> Day11Ex.calculate_grids(300, 42) |> Day11Ex.calculate_grids_max_square_power(300, 3)
      {{21,61}, 30}
  """
  def calculate_grids_max_square_power({_grid, summed_grid}, grid_size, square_size) do
    Enum.reduce(
      1..(grid_size - square_size + 1),
      {nil, nil},
      fn x, acc ->
        Enum.reduce(1..(grid_size - square_size + 1), acc, fn y, {_coords, max_total} = acc ->
          new_total = calculate_square_power(summed_grid, x, y, square_size)

          if max_total == nil || new_total > max_total do
            {{x, y}, new_total}
          else
            acc
          end
        end)
      end
    )
  end

  @doc """
      iex> Day11Ex.calculate_grids(300, 18) |> Day11Ex.calculate_grids_any_max_square_power(300)
      {{90, 269}, 113, 16}

      iex> Day11Ex.calculate_grids(300, 42) |> Day11Ex.calculate_grids_any_max_square_power(300)
      {{232, 251}, 119, 12}
  """
  def calculate_grids_any_max_square_power(grids, grid_size) do
    1..grid_size
    |> Task.async_stream(
      fn square_size ->
        {coords, total} = calculate_grids_max_square_power(grids, grid_size, square_size)
        {coords, total, square_size}
      end,
      ordered: false,
      timeout: :infinity
    )
    |> Enum.map(fn {:ok, result} -> result end)
    |> Enum.max_by(fn {_coords, total, _square_size} -> total end)
  end

  @doc """
      iex> Day11Ex.part1()
      {{235,31}, 31}
  """
  def part1() do
    calculate_grids(300, 8772)
    |> calculate_grids_max_square_power(300, 3)
  end

  @doc """
      iex> Day11Ex.part2()
      {{241,65}, 73, 10}
  """
  def part2() do
    calculate_grids(300, 8772)
    |> calculate_grids_any_max_square_power(300)
  end
end
