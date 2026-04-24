defmodule NucleotideCount do
  @moduledoc """
  What I learned in this exercise:

  - Enum.frequencies is a thing - https://hexdocs.pm/elixir/1.19.5/Enum.html#frequencies/1

  """
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    strand
    |> Enum.count(&(&1 == nucleotide))
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    Map.merge(
      Map.new(@nucleotides, &{&1, 0}),
      Enum.frequencies(strand)
    )
  end
end
