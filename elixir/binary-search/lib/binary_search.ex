defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    # numbers into a sorted list
    numbers
    |> Tuple.to_list()
    |> Enum.sort()
    |> binary_search(key)
  end

  defp binary_search(haystack, needle) do
    binary_search(haystack, needle, 0, length(haystack) - 1)
  end

  defp binary_search(haystack, needle, low, high) do
    # calculate the index for this pass
    index = low + div(high - low, 2)

    # and now we know that we can search
    cond do
      # matches - winner winner chicken dinner
      Enum.at(haystack, index) == needle ->
        {:ok, index}

      # low > high means it's not found
      low > high ->
        :not_found

      # needle is higher in the haystack, search up
      Enum.at(haystack, index) < needle ->
        low = index + 1
        binary_search(haystack, needle, low, high)

      # needle is lower in the haystack, search down
      Enum.at(haystack, index) > needle ->
        high = index - 1
        binary_search(haystack, needle, low, high)

      true ->
        :error
    end
  end
end
