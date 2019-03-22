defmodule ParserTest do
  use ExUnit.Case, async: true

  describe "grid/1" do
    test "can parse grid input" do
      assert {:ok, {4, 8}} == Parser.grid("4 8")
    end

    test "fails if wrong input" do
      assert :error == Parser.grid("48")
    end

    test "fails if non integers given" do
      assert :error == Parser.grid("a b")
    end
  end

  describe "commands/1" do
    test "can parse valid commands" do
      assert {:ok, {{0, 0, :north}, [:f]}} == Parser.commands("(0, 0, N), F")
      assert {:ok, {{0, 0, :north}, [:f]}} == Parser.commands("(0,0,N),F")
    end

    test "error for invalid input" do
      assert :error == Parser.commands("jank")
      assert :error == Parser.commands("(A,0,N),F")
      assert :error == Parser.commands("(0,A,N),F")
      assert :error == Parser.commands("(0,0,Q),F")
      assert :error == Parser.commands("(0,0,N),S")
    end
  end
end
