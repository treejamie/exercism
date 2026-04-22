defmodule ETL do
  @moduledoc """
  What I learned during this exercise

  - list comprehensions are very handy for avoiding nested loops
  - for has an amazing super power - [into](https://hexdocs.pm/elixir/1.19.5/comprehensions.html#the-into-option)

  """
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}

  """
  @spec transform(map) :: map
  def transform(input) do
    for {score, letters} <- input, letter <- letters, into: %{} do
      {letter |> String.downcase(), score}
    end
  end
end
