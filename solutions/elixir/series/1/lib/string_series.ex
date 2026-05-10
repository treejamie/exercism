defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    do_slice(s, 0, size, [])
    |> Enum.reverse()
  end

  defp do_slice(s, _position, size, _slices) when size < 1, do: []

  defp do_slice(s, position, size, slices) do
    slice = String.slice(s, position, size)

    if String.length(slice) == size do
      do_slice(s, position + 1, size, [slice | slices])
    else
      slices
    end
  end
end
