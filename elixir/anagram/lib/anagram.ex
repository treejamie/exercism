defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.reject(fn candidate ->
      String.downcase(base) == String.downcase(candidate)
    end)
    |> Enum.filter(fn candidate ->
      normalise(candidate) == normalise(base)
    end)
  end

  defp normalise(input) do
    input
    |> String.downcase()
    |> to_charlist()
    |> Enum.sort()
  end
end
