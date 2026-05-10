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

  defp equal?(a, b), do: a == b

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
