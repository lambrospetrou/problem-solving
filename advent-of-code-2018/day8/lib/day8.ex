defmodule Day8 do
  @doc """
      iex> Day8.parse_tree([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2])
      {
        [
          {[], [10, 11, 12]},
          {
            [{
              [], [99]
            }],
            [2]
          }
        ],
        [1,1,2]
      }
  """
  def parse_tree(numbers) do
    {tree, _} = do_parse_tree(numbers)
    tree
  end

  def do_parse_tree([0, count_metadata | rest]) do
    {{[], Enum.take(rest, count_metadata)}, Enum.drop(rest, count_metadata)}
  end

  def do_parse_tree([count_children, count_metadata | rest]) do
    {children, rest} =
      Enum.reduce(1..count_children, {[], rest}, fn _, {children, rest} ->
        {child, rest} = do_parse_tree(rest)
        {[child | children], rest}
      end)

    {{Enum.reverse(children), Enum.take(rest, count_metadata)}, Enum.drop(rest, count_metadata)}
  end

  @doc """
      iex> Day8.parse_tree([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]) |> Day8.sum_metadata()
      138
  """
  def sum_metadata(tree) do
    sum_metadata(tree, 0)
  end
  def sum_metadata({children, metadata}, acc) do
    Enum.reduce(children, acc, &sum_metadata/2) + Enum.sum(metadata)
  end

  @doc """
      iex> Day8.parse_tree([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]) |> Day8.root_value()
      66
  """
  def root_value(tree) do
    root_value(tree, 0)
  end
  def root_value({[], metadata}, acc) do
    Enum.sum(metadata) + acc
  end
  def root_value({children, metadata}, acc) do
    tuple_children = List.to_tuple(children)
    children_count = tuple_size(tuple_children)

    Enum.reduce(metadata, acc, fn child_index, acc ->
      cond do
        child_index <= children_count && child_index > 0 -> root_value(elem(tuple_children, child_index-1), acc)
        true -> acc
      end
    end)
  end

  def part1(input \\ "day8-input.txt") do
    File.read!(input)
    |> String.split([" ", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> parse_tree()
    |> sum_metadata()
  end

  def part2(input \\ "day8-input.txt") do
    File.read!(input)
    |> String.split([" ", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> parse_tree()
    |> root_value()
  end
end
