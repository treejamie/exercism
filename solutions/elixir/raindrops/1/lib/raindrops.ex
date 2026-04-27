defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    result =
      [3, 5, 7]
      |> Enum.map(fn divisor -> get_sound(number, divisor) end)

    result
    |> Enum.reject(fn x -> is_integer(x) end)
    |> case do
      [_ | _] = sounds -> Enum.join(sounds)
      _ -> number |> to_string()
    end
  end

  defp get_sound(number, 3) when rem(number, 3) == 0, do: "Pling"
  defp get_sound(number, 5) when rem(number, 5) == 0, do: "Plang"
  defp get_sound(number, 7) when rem(number, 7) == 0, do: "Plong"
  defp get_sound(number, _), do: number
end
