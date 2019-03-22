defmodule Robot do
  def move(position, commands, grid) do
    case new_position(commands, position, grid) do
      {:lost, lost_at} -> {:lost, lost_at}
      new_position -> {:ok, new_position}
    end
  end

  defp new_position(commands, previous_position, grid) do
    Enum.reduce_while(commands, previous_position, fn command, previous_position ->
      with :lost <- execute(command, previous_position, grid) do
        {:halt, {:lost, previous_position}}
      else
        new_position ->
          {:cont, new_position}
      end
    end)
  end

  defp execute(:f, {_, y, :north}, {_, max_y}) when y + 1 == max_y, do: :lost
  defp execute(:f, {x, _, :east}, {max_x, _}) when x + 1 == max_x, do: :lost
  defp execute(:f, {_, y, :south}, _) when y == 0, do: :lost
  defp execute(:f, {x, _, :west}, _) when x == 0, do: :lost

  defp execute(:f, {x, y, :north}, _), do: {x, y + 1, :north}
  defp execute(:f, {x, y, :east}, _), do: {x + 1, y, :east}
  defp execute(:f, {x, y, :south}, _), do: {x, y - 1, :south}
  defp execute(:f, {x, y, :west}, _), do: {x - 1, y, :west}

  defp execute(:r, {x, y, :north}, _), do: {x, y, :east}
  defp execute(:r, {x, y, :east}, _), do: {x, y, :south}
  defp execute(:r, {x, y, :south}, _), do: {x, y, :west}
  defp execute(:r, {x, y, :west}, _), do: {x, y, :north}

  defp execute(:l, {x, y, :north}, _), do: {x, y, :west}
  defp execute(:l, {x, y, :west}, _), do: {x, y, :south}
  defp execute(:l, {x, y, :south}, _), do: {x, y, :east}
  defp execute(:l, {x, y, :east}, _), do: {x, y, :north}
end
