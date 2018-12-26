defmodule Day13Ex do
  @doc """
      iex> Day13Ex.part1()
      {99, 26}
  """
  def part1() do
    File.read!("day13-input.txt")
    |> parse_input()
    |> tick_until_collision()
  end

  def tick_until_collision({map, carts}),
    do: tick_until_collision(tick({map, carts}))

  def tick_until_collision({map, carts, []}),
    do: tick_until_collision(tick({map, carts}))

  def tick_until_collision({_, _, collisions}), do: collisions |> List.last()

  @doc """
      iex> Day13Ex.part2()
      {48, 62}
  """
  def part2() do
    File.read!("day13-input.txt")
    |> parse_input()
    |> tick_until_last_cart_standing()
    |> Enum.map(fn {pos, _} -> pos end)
    |> List.first()
  end

  def tick_until_last_cart_standing({map, carts}),
    do: tick_until_last_cart_standing(tick({map, carts}))

  def tick_until_last_cart_standing({_, carts, _}) when map_size(carts) == 1,
    do: carts |> Enum.take(1)

  def tick_until_last_cart_standing({map, carts, _}),
    do: tick_until_last_cart_standing(tick({map, carts}))

  @doc ~S"""
      iex> Day13Ex.parse_input("/--\\\nv  |\n|  |\n\\--/") |> Day13Ex.tick()
      {
        %{
          {0, 0} => ?/,
          {0, 1} => ?-,
          {0, 2} => ?-,
          {0, 3} => 92,
          {1, 0} => ?|,
          {1, 3} => ?|,
          {2, 0} => ?|,
          {2, 3} => ?|,
          {3, 0} => 92,
          {3, 1} => ?-,
          {3, 2} => ?-,
          {3, 3} => ?/
        },
        %{
          {2,0} => {?v, :left}
        },
        []
      }

      # Check collision
      iex> Day13Ex.parse_input("/--\\\nv  |\n^  |\n\\--/") |> Day13Ex.tick()
      {
        %{
          {0, 0} => ?/,
          {0, 1} => ?-,
          {0, 2} => ?-,
          {0, 3} => 92,
          {1, 0} => ?|,
          {1, 3} => ?|,
          {2, 0} => ?|,
          {2, 3} => ?|,
          {3, 0} => 92,
          {3, 1} => ?-,
          {3, 2} => ?-,
          {3, 3} => ?/
        },
        %{},
        [{2,0}]
      }
  """
  def tick({map, carts}) do
    {_carts, new_carts, collisions} =
      Enum.sort(carts)
      |> Enum.reduce({carts, %{}, []}, fn {{y, x}, cart}, {carts, new_carts, collisions} ->
        if !Map.has_key?(carts, {y, x}) do
          # Cart has been removed in a previous collision in this tick!
          {carts, new_carts, collisions}
        else
          {new_pos, new_cart} = move_cart(y, x, cart, Map.get(map, {y, x}))
          carts = Map.delete(carts, {y, x})

          if Map.has_key?(carts, new_pos) || Map.has_key?(new_carts, new_pos) do
            {Map.delete(carts, new_pos), Map.delete(new_carts, new_pos), [new_pos | collisions]}
          else
            {carts, Map.put(new_carts, new_pos, new_cart), collisions}
          end
        end
      end)

    {map, new_carts, collisions}
  end

  def move_cart(y, x, {?>, next_turn}, ?-), do: {{y, x + 1}, {?>, next_turn}}
  def move_cart(y, x, {?>, next_turn}, ?\\), do: {{y + 1, x}, {?v, next_turn}}
  def move_cart(y, x, {?>, next_turn}, ?/), do: {{y - 1, x}, {?^, next_turn}}
  def move_cart(y, x, {?>, next_turn}, ?+), do: turn(y, x, ?>, next_turn)

  def move_cart(y, x, {?<, next_turn}, ?-), do: {{y, x - 1}, {?<, next_turn}}
  def move_cart(y, x, {?<, next_turn}, ?\\), do: {{y - 1, x}, {?^, next_turn}}
  def move_cart(y, x, {?<, next_turn}, ?/), do: {{y + 1, x}, {?v, next_turn}}
  def move_cart(y, x, {?<, next_turn}, ?+), do: turn(y, x, ?<, next_turn)

  def move_cart(y, x, {?^, next_turn}, ?|), do: {{y - 1, x}, {?^, next_turn}}
  def move_cart(y, x, {?^, next_turn}, ?\\), do: {{y, x - 1}, {?<, next_turn}}
  def move_cart(y, x, {?^, next_turn}, ?/), do: {{y, x + 1}, {?>, next_turn}}
  def move_cart(y, x, {?^, next_turn}, ?+), do: turn(y, x, ?^, next_turn)

  def move_cart(y, x, {?v, next_turn}, ?|), do: {{y + 1, x}, {?v, next_turn}}
  def move_cart(y, x, {?v, next_turn}, ?\\), do: {{y, x + 1}, {?>, next_turn}}
  def move_cart(y, x, {?v, next_turn}, ?/), do: {{y, x - 1}, {?<, next_turn}}
  def move_cart(y, x, {?v, next_turn}, ?+), do: turn(y, x, ?v, next_turn)

  def turn(y, x, ?>, :left), do: {{y - 1, x}, {?^, :straight}}
  def turn(y, x, ?>, :straight), do: {{y, x + 1}, {?>, :right}}
  def turn(y, x, ?>, :right), do: {{y + 1, x}, {?v, :left}}
  def turn(y, x, ?<, :left), do: {{y + 1, x}, {?v, :straight}}
  def turn(y, x, ?<, :straight), do: {{y, x - 1}, {?<, :right}}
  def turn(y, x, ?<, :right), do: {{y - 1, x}, {?^, :left}}
  def turn(y, x, ?^, :left), do: {{y, x - 1}, {?<, :straight}}
  def turn(y, x, ?^, :straight), do: {{y - 1, x}, {?^, :right}}
  def turn(y, x, ?^, :right), do: {{y, x + 1}, {?>, :left}}
  def turn(y, x, ?v, :left), do: {{y, x + 1}, {?>, :straight}}
  def turn(y, x, ?v, :straight), do: {{y + 1, x}, {?v, :right}}
  def turn(y, x, ?v, :right), do: {{y, x - 1}, {?<, :left}}

  @doc ~S"""
      iex> Day13Ex.parse_input("/--\\\nv  |\n|  |\n\\--/")
      {
        %{
          {0, 0} => ?/,
          {0, 1} => ?-,
          {0, 2} => ?-,
          {0, 3} => 92,
          {1, 0} => ?|,
          {1, 3} => ?|,
          {2, 0} => ?|,
          {2, 3} => ?|,
          {3, 0} => 92,
          {3, 1} => ?-,
          {3, 2} => ?-,
          {3, 3} => ?/
        },
        %{
          {1, 0} => {?v, :left}
        }
      }
  """
  def parse_input(input) do
    lines = String.split(input, "\n", trim: true)

    {map, carts, _} =
      lines
      |> Enum.reduce({%{}, %{}, 0}, fn line, {map, carts, y} ->
        {map, carts} =
          line
          |> String.to_charlist()
          |> Enum.with_index()
          |> Enum.reduce({map, carts}, fn {symbol, x}, {map, carts} ->
            map = parse_symbol(map, {y, x}, symbol)
            carts = parse_cart(carts, {y, x}, symbol)
            {map, carts}
          end)

        {map, carts, y + 1}
      end)

    {map, carts}
  end

  def parse_symbol(map, _pos, 32), do: map
  def parse_symbol(map, pos, symbol) when symbol in [?>, ?<], do: Map.put(map, pos, ?-)
  def parse_symbol(map, pos, symbol) when symbol in [?v, ?^], do: Map.put(map, pos, ?|)
  def parse_symbol(map, pos, symbol), do: Map.put(map, pos, symbol)

  def parse_cart(carts, pos, symbol) when symbol in [?>, ?<, ?v, ?^],
    do: Map.put(carts, pos, {symbol, :left})

  def parse_cart(carts, _pos, _symbol), do: carts
end
