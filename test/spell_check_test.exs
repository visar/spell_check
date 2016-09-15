defmodule SpellCheckTest do
  use ExUnit.Case
  doctest SpellCheck

  @tag :pending
  test "Word Frequency" do
    assert WordFrequency.words(Path.absname("test/small.txt")) ==
      %{"first" => 1, "recently" => 1, "redistributing" => 1, "a" => 1, "both" => 1,
        "holmes" => 4, "arthur" => 3, "title" => 1, "important" => 1, "viewing" => 1,
        "november" => 1, "additional" => 1, "world" => 2, "header" => 2,
        "bottom" => 1, "readable" => 1, "were" => 1, "seen" => 1, "ascii" => 1,
        "restrictions" => 1, "about" => 3, "adventures" => 4, "updated" => 1,
        "are" => 1, "humans" => 1, "ebooks" => 2, "before" => 1, "read" => 1,
        "downloading" => 1, "country" => 1, "also" => 1, "ebook" => 5, "get" => 1,
        "check" => 1, "other" => 2, "encoding" => 1, "set" => 1, "rights" => 1,
        "edit" => 1, "character" => 1, "over" => 1, "sir" => 3, "plain" => 1,
        "permission" => 1, "march" => 1, "can" => 1, "should" => 1, "laws" => 2,
        "edition" => 1, "file" => 3, "electronic" => 1, "sherlock" => 4, "thing" => 1,
        "the" => 15, "find" => 1, "series" => 1, "all" => 1, "involved" => 1,
        "written" => 1, "our" => 1, "copyright" => 2, "jose" => 1, "please" => 2,
        "thousands" => 1, "start" => 1, "not" => 2, "computers" => 1, "and" => 5,
        "author" => 1, "any" => 1, "used" => 1, "project" => 6, "do" => 2,
        "texts" => 1, "welcome" => 1, "since" => 1, "when" => 1, "at" => 1,
        "date" => 1, "your" => 2, "of" => 9, "information" => 2, "small" => 1,
        "out" => 1, "remove" => 1, "change" => 1, "editing" => 1, "make" => 1,
        "this" => 4, "donation" => 1, "language" => 1, "how" => 3, "without" => 1,
        "print" => 1, "specific" => 1, "release" => 1, "in" => 2, "most" => 1,
        "vanilla" => 1, "menendez" => 1, "it" => 1, "be" => 3, "may" => 1,
        "conan" => 3, "free" => 1, "volunteers" => 1, "you" => 1, "english" => 1,
        "these" => 1, "changing" => 1, "is" => 1, "prepared" => 1, "sure" => 1,
        "to" => 5, "doyle" => 3, "by" => 6, "or" => 3, "included" => 1, "legal" => 1,
        "gutenberg" => 6, "for" => 1}
  end

  @tag :pending
  test "insert" do
    assert SpellCheck.correction("speling") == "spelling"
  end

  @tag :pending
  test "replace" do
    assert SpellCheck.correction("bycycle") == "bicycle"
  end

  @tag :pending
  test "replace 1" do
    assert SpellCheck.correction("correctud") == "corrected"
  end

  # @tag :pending
  test "replace 2" do
    assert SpellCheck.correction("korrectud") == "corrected"
  end

  @tag :pending
  test "the truth" do
    assert 1 + 1 == 2
  end
end
