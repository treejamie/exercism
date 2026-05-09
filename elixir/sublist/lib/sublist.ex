defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, b) do
    cond do
      equal?(a, b) -> :equal
      contains?(b, a) -> :sublist
      contains?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp equal?([], []), do: true
  defp equal?([], _), do: false
  defp equal?(_, []), do: false
  defp equal?([h | tail_1], [h | tail_2]), do: equal?(tail_1, tail_2)
  defp equal?([_ | _], [_ | _]), do: false

  defp contains?(_, []), do: true
  defp contains?([], _), do: false

  defp contains?([_ | t] = haystack, needle) do
    if starts_with?(haystack, needle) do
      true
    else
      contains?(t, needle)
    end
  end

  defp starts_with?(_, []), do: true
  defp starts_with?([], _), do: false
  defp starts_with?([h | tail_1], [h | tail_2]), do: starts_with?(tail_1, tail_2)
  defp starts_with?([_ | _], [_ | _]), do: false
end
