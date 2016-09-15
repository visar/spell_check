defmodule SpellCheck do
  @word_frequency WordFrequency.words
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
      (words = known([word])) != MapSet.new -> words
      (words = (word |> edits1 |> MapSet.to_list |> known)) != MapSet.new -> words
      (words = (word |> edits2 |> MapSet.to_list |> known)) != MapSet.new -> words
      true -> [word]
    end
  end

  def known(words) do
    (for w <- words, ^w <- Map.keys(@word_frequency), do: w)
    |> MapSet.new
  end

  def edits1(word) do
    splits = for i <- 0..String.length(word), do: String.split_at(word, i)
    deletes = for {left, right} <- splits, right != "", do: left <> String.slice(right, 1, :infinity)
    transposes = for {left, right} <- splits, String.length(right) > 1, do: left <> String.at(right, 1) <> String.at(right, 0) <> String.slice(right, 2, :infinity)
    replaces = for {left, right} <- splits, char <- ?a..?z |> Enum.to_list, right != "", do: left <> ([char] |> to_string) <> String.slice(right, 1, :infinity)
    inserts = for {left, right} <- splits, char <- ?a..?z |> Enum.to_list, do: left <> ([char] |> to_string) <> right
    MapSet.new(deletes ++ transposes ++ replaces ++ inserts)
  end

  def edits2(word) do
    for e1 <- edits1(word), e2 <- edits1(e1), into: MapSet.new, do: e2
  end
end
