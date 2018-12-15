defmodule Day6Ex do
  @doc """
      iex> Day6Ex.parse_coords("
      ...>   1, 1,
      ...>   1, 6,
      ...>   8, 3,
      ...>   3, 4,
      ...>   5, 5,
      ...>   8, 9,
      ...> ")
      {[{8,9}, {5,5}, {3,4}, {8,3}, {1,6}, {1,1}], {1, 1, 8, 9}}
  """
  def parse_coords(string) do
    string
    |> String.split([" ", "\n", ","], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.reduce({[], {nil, nil, 0, 0}}, fn [x,y], {coords, {minx, miny, maxx, maxy}} ->
      {[{x,y} | coords], {min(minx, x), min(miny, y), max(maxx, x), max(maxy, y)}}
    end)
  end

  def manhattan(ax, ay, bx, by), do: abs(ax-bx) + abs(ay-by)

  @doc """
      iex> Day6Ex.mark_grid_owners({[{1,2}, {2,1}, {3,3}], {1, 1, 3, 3}})
      {%{
        {1,1} => {-1, 1},
        {1,2} => {0, 0},
        {1,3} => {0, 1},
        {2,1} => {1, 0},
        {2,2} => {-1, 1},
        {2,3} => {2, 1},
        {3,1} => {1, 1},
        {3,2} => {2, 1},
        {3,3} => {2, 0}
      }, [{1,2}, {2,1}, {3,3}], {1, 1, 3, 3}}
  """
  def mark_grid_owners({coords, {minx, miny, maxx, maxy}}) do
    coords_with_idx = Enum.zip(coords, 0..(length(coords)-1))
    # Naively process each coordinate across the whole grid
    marked =
      Enum.reduce(coords_with_idx, %{}, fn {{x, y}, id}, grid ->
        Enum.reduce(minx..maxx, grid, fn posx, grid ->
          Enum.reduce(miny..maxy, grid, fn posy, grid ->
            distance = manhattan(x, y, posx, posy)
            Map.update(grid, {posx, posy}, {id, distance}, fn {cid, cdistance} ->
              cond do
                distance == cdistance -> {-1, cdistance}
                distance < cdistance -> {id, distance}
                true -> {cid, cdistance}
              end
            end)
          end)
        end)
      end)
    {marked, coords, {minx, miny, maxx, maxy}}
  end

  @doc """
      iex> Day6Ex.max_area_owner({%{
      ...> {1,1} => {0, 1},
      ...> {1,2} => {-1, -1},
      ...> {1,3} => {2, 0},
      ...> {2,1} => {0, 0},
      ...> {2,2} => {1, 0},
      ...> {2,3} => {-1, -1},
      ...> {3,1} => {-1, -1},
      ...> {3,2} => {3, 0},
      ...> {3,3} => {3, 1}
      ...> }, [{2,1}, {2,2}, {1,3}, {3,2}], {1, 1, 3, 3}})
      {1, 1}
  """
  def max_area_owner({grid, _coords, box}) do
    infinites = get_infinites(grid, box)

    Enum.reduce(grid, %{}, fn
      {_, {-1, _}}, counters -> counters
      {_, {id, _}}, counters -> Map.update(counters, id, 1, &(&1 + 1))
    end)
    |> Enum.reduce({nil, -1}, fn {id, count}, {maxid, maxcount} ->
      cond do
        MapSet.member?(infinites, id) -> {maxid, maxcount}
        count > maxcount -> {id, count}
        true -> {maxid, maxcount}
      end
    end)
  end

  @doc """
      iex> Day6Ex.get_infinites(%{
      ...> {1,1} => {0, 5},
      ...> {1,2} => {-1, 5},
      ...> {1,3} => {1, 5},
      ...> {2,1} => {0, 5},
      ...> {2,2} => {2, 5},
      ...> {2,3} => {-1, 5},
      ...> {3,1} => {-1, 5},
      ...> {3,2} => {3, 5},
      ...> {3,3} => {3, 5},
      ...> }, {1,1,3,3}) |> MapSet.to_list()
      [0,1,3]
  """
  def get_infinites(grid, {minx, miny, maxx, maxy}) do
    x =
      for y <- [miny, maxy],
          x <- minx..maxx,
          {id, _} = grid[{x, y}],
          do: id
    y =
      for x <- [minx, maxx],
          y <- miny..maxy,
          {id, _} = grid[{x, y}],
          do: id

    MapSet.new(x ++ y) |> MapSet.delete(-1)
  end


  @doc """
      iex> Day6Ex.part1_string("
      ...> 1, 1,
      ...> 1, 6,
      ...> 8, 3,
      ...> 3, 4,
      ...> 5, 5,
      ...> 8, 9,
      ...> ")
      {1, 17}
  """
  def part1_string(string) do
    string
    |> parse_coords()
    |> mark_grid_owners()
    |> max_area_owner()
  end

  def part1(input \\ "day6-input.txt") do
    File.read!(input)
    |> part1_string()
  end

end
