defmodule SpellCheck do
  import :erlang, only: [iolist_to_binary: 1]

  @default_filename Path.absname("lib/big.txt")
  @chars ?a..?z |> Enum.to_list
  @empty_set MapSet.new()
  @word_frequency Regex.split(~r/[\s+]/,
                              @default_filename
                              |> File.read!
                              |> String.downcase)
                              |> Enum.filter(fn(x) -> x != "" end)
                  |> Enum.reduce(Map.new,
                                 fn(item, acc) -> Map.update(acc, item, 1, &(&1 + 1)) end)
  @word_keys @word_frequency |> Map.keys |> MapSet.new
  @total @word_frequency |> Map.values |> Enum.sum

  def words do
    @word_frequency
  end

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
      (words = known(MapSet.put(@empty_set, word))) != @empty_set -> words
      (words = (word |> edits1 |> known)) != @empty_set -> words
      (words = (word |> edits2 |> known)) != @empty_set -> words
      true -> [word]
    end
  end

  def known(words) do
    MapSet.intersection(words, @word_keys)
  end

  def edits1(word) do
    splits = for i <- 0..String.length(word) do
      {left, right} = String.split_at(word, i)
      {String.to_charlist(left), String.to_charlist(right)}
    end

    []
    |> deletes(splits)
    |> transposes(splits)
    |> replaces(splits)
    |> inserts(splits)
    |> MapSet.new()
  end

  defp deletes(set, splits) do
    for {left, [_|right]} <- splits, into: set do
      iolist_to_binary([left, right])
    end
  end

  defp transposes(set, splits) do
    for {left, [a,b|right]} <- splits, into: set do
      iolist_to_binary([left, b, a, right])
    end
  end

  defp replaces(set, splits) do
    for {left, [_|right]} <- splits, char <- @chars, into: set do
      iolist_to_binary([left, char, right])
    end
  end

  defp inserts(set, splits) do
    for {left, right} <- splits, char <- @chars, into: set do
      iolist_to_binary([left, char, right])
    end
  end

  def edits2(word) do
    (for e1 <- edits1(word), e2 <- edits1(e1), do: e2) |> MapSet.new
  end
end
