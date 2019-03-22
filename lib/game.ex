defmodule Game do
  def main(args) do
    grid_input = read_input("Enter the grid size (e.g. 4 8) > ")

    with {:ok, grid} <- Parser.grid(grid_input) do
      command(grid)
    else
      :error ->
        IO.puts(~s|Invalid grid information! Make sure it is in the format "4 8"|)
        main(args)
    end
  end

  defp command(grid) do
    commands_input = read_input(~s|Enter robot commands (e.g. "(0, 0, N), FFLRFF") > |)

    with {:ok, {position, commands}} <- Parser.commands(commands_input),
         {:ok, new_position} <- Robot.move(position, commands, grid) do
      IO.puts("Robot successfully moved to: #{inspect(new_position)}")
    else
      :error ->
        IO.puts(~s|Invalid command! Make sure it is in the format "(0 0 N), FFLRFF"|)

      {:lost, lost_at} ->
        IO.puts("Robot was unfortunately lost at: #{inspect(lost_at)}")
    end

    command(grid)
  end

  defp read_input(prompt) do
    prompt
    |> IO.gets()
    |> String.replace("\n", "")
  end
end
