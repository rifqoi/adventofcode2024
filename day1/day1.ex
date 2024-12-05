defmodule Day1 do
  def read_lines(filename) do
    {:ok, contents} = File.read(filename)
    contents |> String.split("\n", trim: true)
  end

  def part1(input) do
    input
    |> Enum.map(&String.split(&1))
    |> Enum.map(fn [a, b] ->
      {String.to_integer(a), String.to_integer(b)}
    end)
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part1_2(input) do
    to_integer(input)
    |> zip()
    |> Enum.map(fn row -> Enum.sort(row) end)
    |> zip()
    |> Enum.map(&List.to_tuple/1)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def to_integer([]), do: []

  def to_integer([head | tail]) when is_binary(head) do
    row =
      String.split(head)
      |> Enum.map(&String.to_integer(&1))

    [row | to_integer(tail)]
  end

  def zip([]), do: []

  def zip(list) when is_list(list) do
    # IO.inspect(list)

    # To prevent empty list being added
    if Enum.any?(list, &(&1 == [])) do
      []
    else
      heads = for [head | _] <- list, do: head
      tails = for [_ | tail] <- list, do: tail

      [heads | zip(tails)]
    end
  end
end
