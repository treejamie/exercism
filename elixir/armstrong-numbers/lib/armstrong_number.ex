defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number.


  What I learned in this exercise.

  * :math.pow returns a float, which over a large enough number isn't accurate
    (this is why you don't use floats for currency btw - they're not accurate)
  * Integer.pow however, is accurate and does exact integer arthitmetic.


  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    input =
      number
      |> to_string()
      |> String.split("", trim: true)

    input
    |> Enum.map(fn value ->
      value
      |> String.to_integer()
      |> Integer.pow(input |> length)
    end)
    |> Enum.sum()
    |> then(fn result -> result == number end)
  end
end
