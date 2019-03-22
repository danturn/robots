defmodule RobotTest do
  use ExUnit.Case
  doctest Robot

  @default_grid {10, 10}

  describe "move/1" do
    test ":f moves one block north" do
      position = {0, 0, :north}
      commands = [:f]
      assert {:ok, {0, 1, :north}} == Robot.move(position, commands, @default_grid)
    end

    test ":f moves one block east" do
      position = {0, 0, :east}
      commands = [:f]
      assert {:ok, {1, 0, :east}} == Robot.move(position, commands, @default_grid)
    end

    test ":f moves one block south" do
      position = {0, 1, :south}
      commands = [:f]
      assert {:ok, {0, 0, :south}} == Robot.move(position, commands, @default_grid)
    end

    test ":f moves one block west" do
      position = {1, 0, :west}
      commands = [:f]
      assert {:ok, {0, 0, :west}} == Robot.move(position, commands, @default_grid)
    end

    test ":r changes direction" do
      position = {0, 0, :north}
      commands = [:r]
      assert {:ok, {0, 0, :east}} == Robot.move(position, commands, @default_grid)
    end

    test "four :r turns returns to initial direction" do
      position = {0, 0, :north}
      commands = [:r, :r, :r, :r]
      assert {:ok, {0, 0, :north}} == Robot.move(position, commands, @default_grid)
    end

    test ":l changes direction" do
      position = {0, 0, :north}
      commands = [:l]
      assert {:ok, {0, 0, :west}} == Robot.move(position, commands, @default_grid)
    end

    test "four :l turns returns to initial direction" do
      position = {0, 0, :north}
      commands = [:l, :l, :l, :l]
      assert {:ok, {0, 0, :north}} == Robot.move(position, commands, @default_grid)
    end

    test "lost if goes off the top of the grid" do
      position = {0, 0, :north}
      commands = [:f]
      assert {:lost, {0, 0, :north}} == Robot.move(position, commands, {1, 1})
    end

    test "lost if goes off the bottom of the grid" do
      position = {0, 0, :south}
      commands = [:f]
      assert {:lost, {0, 0, :south}} == Robot.move(position, commands, {1, 1})
    end

    test "lost if goes off the right of the grid" do
      position = {0, 0, :east}
      commands = [:f]
      assert {:lost, {0, 0, :east}} == Robot.move(position, commands, {1, 1})
    end

    test "lost if goes off the left of the grid" do
      position = {0, 0, :west}
      commands = [:f]
      assert {:lost, {0, 0, :west}} == Robot.move(position, commands, {1, 1})
    end

    test "ignores additional commands after lost" do
      position = {0, 0, :west}
      commands = [:f, :f, :f, :f]
      assert {:lost, {0, 0, :west}} == Robot.move(position, commands, {1, 1})
    end

    test "mixed valid commands" do
      position = {2, 3, :north}
      commands = [:f, :l, :l, :f, :r]
      assert {:ok, {2, 3, :west}} == Robot.move(position, commands, @default_grid)
    end

    test "mixed commands resulting in lost" do
      position = {1, 0, :south}
      commands = [:f, :f, :r, :l, :f]
      assert {:lost, {1, 0, :south}} == Robot.move(position, commands, {4, 8})
    end
  end
end
