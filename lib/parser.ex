defmodule Parser do
  def grid(input) do
    case String.split(input) do
      [x, y] ->
        x_and_y(x, y)

      _ ->
        :error
    end
  end

  def commands(input) do
    with [position, commands] <-
           input
           |> String.replace(" ", "")
           |> String.split("),"),
         {:ok, position} <- position(position),
         {:ok, commands} <- do_commands(commands) do
      {:ok, {position, commands}}
    else
      _ -> :error
    end
  end

  defp position(position) do
    with [x, y, direction] <-
           position
           |> String.replace("(", "")
           |> String.split(","),
         {:ok, {x, y}} <- x_and_y(x, y),
         {:ok, direction} <- direction(direction) do
      {:ok, {x, y, direction}}
    else
      _ -> :error
    end
  end

  defp direction("N"), do: {:ok, :north}
  defp direction("E"), do: {:ok, :east}
  defp direction("S"), do: {:ok, :south}
  defp direction("W"), do: {:ok, :west}
  defp direction(_), do: :error

  defp x_and_y(x, y) do
    with {x, ""} <- Integer.parse(x),
         {y, ""} <- Integer.parse(y) do
      {:ok, {x, y}}
    else
      _ -> :error
    end
  end

  defp do_commands(commands) do
    commands =
      commands
      |> String.graphemes()
      |> Enum.map(fn
        command ->
          case(command) do
            "F" -> :f
            "L" -> :l
            "R" -> :r
            _ -> :invalid_command
          end
      end)

    if Enum.any?(commands, fn x -> x == :invalid_command end) do
      :error
    else
      {:ok, commands}
    end
  end
end
