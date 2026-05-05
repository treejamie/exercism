defmodule Hamming do
  @doc """

  What I learned in this exercise:

  - I made friends with Enum.zip

  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "strands must be of equal length"}
  end

  def hamming_distance(strand1, strand2) do
    {:ok,
     Enum.zip(strand1, strand2)
     |> Enum.reject(fn {s1, s2} ->
       s1 == s2
     end)
     |> length()}
  end
end
