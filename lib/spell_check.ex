defmodule SpellCheck do

  @chars ?a..?z |> Enum.to_list |> Enum.map(&([ &1 ]))
  @empty_set MapSet.new()

  @word_frequency WordFrequency.words
  @word_keys @word_frequency |> Map.keys |> MapSet.new

  @total @word_frequency |> Map.values |> Enum.sum

  def probability(word, N \\ @total) do
    Map.get(@word_frequency, word) / N
  end

  def correction(word) do
    candidates(word)
    |> Enum.max
    # |> Enum.max_by(&probability/2)
  end

  def candidates(word) do
    cond do
      (words = known(MapSet.put(@empty_set, word)) != @empty_set -> words
      (words = (word |> edits1 |> known)) != @empty_set -> words
      (words = (word |> edits2 |> known)) != @empty_set -> words
      true -> [word]
    end
  end

  def known(words) do
    MapSet.intersection(words, @word_keys)
  end

  def edits1(word) do
    splits = for i <- 0..String.length(word), do: String.split_at(word, i)
    deletes = for {left, right} <- splits, right != "", do: left <> String.slice(right, 1, :infinity)
    transposes = for {left, right} <- splits, String.length(right) > 1, do: left <> String.at(right, 1) <> String.at(right, 0) <> String.slice(right, 2, :infinity)
    replaces = for {left, right} <- splits, char <- @chars, right != "", do: left <> (char |> to_string) <> String.slice(right, 1, :infinity)
    inserts = for {left, right} <- splits, char <- @chars, do: left <> (char |> to_string) <> right

    mapset = MapSet.new(deletes)

    mapset = MapSet.union(mapset, MapSet.new(transposes))
    mapset = MapSet.union(mapset, MapSet.new(replaces))
    mapset = MapSet.union(mapset, MapSet.new(inserts))

    mapset
  end

  def edits2(word) do
    for e1 <- edits1(word), e2 <- edits1(e1), into: MapSet.new, do: e2
  end

end
