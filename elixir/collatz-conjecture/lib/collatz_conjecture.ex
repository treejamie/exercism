defmodule CollatzConjecture do
  @moduledoc """
  What I learned in this exercise.

  - trust myself more.
  - community solutions contain some gems. The below was by rlb3

  https://exercism.org/tracks/elixir/exercises/collatz-conjecture/solutions/rlb3

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_number(input) and input > 0 do
    input
    |> Stream.iterate(&do_collatz/1)
    |> Stream.take_while(&(&1 != 1))
    |> Enum.to_list()
    |> length()
  end

  defp do_collatz(n) do
    cond do
      Integer.is_even(n) -> div(n, 2)
      :else -> 3 * n + 1
    end
  end

  I saved it here for my own reference becasue it feels like a very idiomatic
  way to do the recursion rather than the "textbook" way of multiple function signatures.

  Look how concise it is.

  Oh my.


  """
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()

  def calc(input)
      when is_integer(input) and input > 0,
      do: do_calc(input, 0)

  defp do_calc(1, steps), do: steps

  defp do_calc(input, steps) when rem(input, 2) == 0 do
    do_calc(div(input, 2), steps + 1)
  end

  defp do_calc(input, steps) do
    do_calc(input * 3 + 1, steps + 1)
  end
end
