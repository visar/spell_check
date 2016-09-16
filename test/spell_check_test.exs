defmodule SpellCheckTest do
  use ExUnit.Case
  doctest SpellCheck

  # @tag :pending
  test "insert" do
    assert SpellCheck.correction("speling") == "spelling"
  end

  # @tag :pending
  test "replace" do
    assert SpellCheck.correction("bycycle") == "bicycle"
  end

  # @tag :pending
  test "replace 1" do
    assert SpellCheck.correction("correctud") == "corrected"
  end

  # @tag :pending
  test "replace 2" do
    assert SpellCheck.correction("korrectud") == "corrected"
  end
end
