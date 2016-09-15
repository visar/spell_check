defmodule WordFrequency do
  @default_filename Path.absname("lib/big.txt")

  def words(filename \\ @default_filename) do
    Regex.split(~r/\s+/,
      filename
      |> File.read!
      |> String.downcase)
      |> Enum.filter(fn(x) -> x != "" end)
    |> Enum.reduce(Map.new, fn(item, acc) -> Map.update(acc, item, 1, &(&1 + 1)) end)
  end
end
