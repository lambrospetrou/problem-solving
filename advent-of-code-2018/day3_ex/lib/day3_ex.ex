defmodule Day3Ex do

  def parse_id([<<?#, id::binary>> | _]), do: id |> String.to_integer()
  def parse_xy([_, _, xy | _]), do: xy |> String.trim_trailing(":") |> String.split(",") |> Enum.map(&String.to_integer/1)
  def parse_wh([_, _, _, wh]), do: wh |> String.split("x") |> Enum.map(&String.to_integer/1)

  def parse_claims(lines) do
    lines
    |> Enum.map(fn line -> 
      String.split(line, " ", trim: true, parts: 4)
      |> (fn parts -> 
        id = parse_id(parts)
        [x, y] = parse_xy(parts)
        [w, h] = parse_wh(parts)

        %{id: id, x: x, y: y, w: w, h: h} 
      end).()
    end)
  end

  def count_two_plus(claims) do
    claims
    |> get_map_of_claims()
    |> Enum.count(fn {_k, v} -> v > 1 end)
  end

  def get_map_of_claims(claims) do
    claims
    |> Enum.reduce(%{}, fn claim, m ->
      all = for w <- 0..(claim.w-1), h <- 0..(claim.h-1), into: [], do: {w + claim.x, h + claim.y}
      all |> Enum.reduce(m, fn pos, m -> Map.update(m, pos, 1, &(&1 + 1)) end)
    end)
  end

  def no_overlap_claim(claims) do
    m = claims |> get_map_of_claims()
    
    claims 
    |> Enum.reduce_while(nil, fn claim, _ ->
      positions = for w <- 0..(claim.w-1), h <- 0..(claim.h-1), into: [], do: {w + claim.x, h + claim.y}

      answer = positions |> Enum.all?(fn key -> Map.get(m, key) == 1 end)
      
      if answer do
        {:halt, claim.id}
      else
        {:cont, nil}
      end
    end)
  end

  def part1(input \\ "day3-input.txt") do
    get_input(input)
    |> parse_claims()
    |> count_two_plus()
  end

  def part2(input \\ "day3-input.txt") do
    get_input(input)
    |> parse_claims()
    |> no_overlap_claim()
  end

  def get_input(input) do
    File.read!(input)
    |> String.split("\n", trim: true)
  end
end
