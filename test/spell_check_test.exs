defmodule SpellCheckTest do
  use ExUnit.Case
  doctest SpellCheck

  # @tag :pending
  test "insert - edit distance 1" do
    assert SpellCheck.correction("speling") == "spelling"
  end

  # @tag :pending
  test "insert - edit distance 2" do
    assert SpellCheck.correction("inconvient") == "inconvenient"
  end

  # @tag :pending
  test "replace - edit distance 1" do
    assert SpellCheck.correction("bycycle") == "bicycle"
  end

  # @tag :pending
  test "replace - edit distance 2" do
    assert SpellCheck.correction("korrectud") == "corrected"
  end

  # @tag :pending
  test "delete" do
    assert SpellCheck.correction("arrainged") == "arranged"
  end

  # @tag :pending
  test "transpose" do
    assert SpellCheck.correction("peotry") == "poetry"
  end

  # @tag :pending
  test "transpose + delete" do
    assert SpellCheck.correction("peotryy") == "poetry"
  end

  # @tag :pending
  test "known" do
    assert SpellCheck.correction("word") == "word"
  end

  # @tag :pending
  test "unkown" do
    assert SpellCheck.correction("quintessential") == "quintessential"
  end

  # @tag :pending
  test "size of training set" do
    assert SpellCheck.words |> Map.keys |> length == 29152
  end

  # @tag :pending
  test "total number of occurrences of the words from the training set" do
    assert SpellCheck.words |> Map.values |> Enum.sum == 1105221
  end

  # @tag :pending
  test "most common words" do
    assert SpellCheck.words |> Enum.sort_by(fn{_,v} -> v end, &>=/2) |> Enum.take(10) == [{"the", 80030},
                                                                                          {"of", 40025},
                                                                                          {"and", 38312},
                                                                                          {"to", 28766},
                                                                                          {"in", 22047},
                                                                                          {"a", 21155},
                                                                                          {"that", 12512},
                                                                                          {"he", 12401},
                                                                                          {"was", 11410},
                                                                                          {"it", 10681}]
  end

  # @tag :pending
  test "count of \"the\"" do
    assert SpellCheck.words["the"] == 80030
  end
end
