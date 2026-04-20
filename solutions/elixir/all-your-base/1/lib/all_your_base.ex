defmodule AllYourBase do
  @moduledoc """

  AllYourBase has a strong link to maths. When there's a maths aspect
  I tend to over document as I'm really not that keen on maths stuff.
  I came for the ELixir, but I'll slog it through the maths...

  What I learned in this exercise.

  * Horner's method - a clever way of switching between bases in On
  * I should be placing my learnings into anki. This isn't the first time that I've had to lookup "quotient"
  * I like the validate pattern that uses cond

  """
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2.
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    # before we get into Horners method validate the inpuit

    with {:ok, digits} <- validate_values(digits, input_base, output_base) do
      # Step 1. Get the digits into an integer for input base starting
      base_integer =
        Enum.reduce(digits, 0, fn digit, acc ->
          acc * input_base + digit
        end)

      # Step 2. integer division and remainder until quotient (result of division) is zero
      #         the remainder becomes part of the result.
      result = do_output([], base_integer, output_base)

      {:ok, result}
    else
      {:error, [0]} -> {:ok, [0]}
      err -> err
    end
  end

  defp validate_values(digits, input_base, output_base) do
    cond do
      input_base < 2 ->
        {:error, "input base must be >= 2"}

      output_base < 2 ->
        {:error, "output base must be >= 2"}

      Enum.any?(digits, fn x -> x < 0 end) ->
        {:error, "all digits must be >= 0 and < input base"}

      Enum.any?(digits, fn x -> x >= input_base end) ->
        {:error, "all digits must be >= 0 and < input base"}

      # Enum.all?(digits, fn x -> x == 0 end) ->
      #   {:error, [0]}

      true ->
        {:ok, digits}
    end
  end

  defp do_output([], 0, _), do: [0]
  defp do_output(output, 0, _output_base), do: output

  defp do_output(output, integer, output_base) do
    # the quotient becomes the input for the next run
    quotient = div(integer, output_base)
    # the remainder becomes the result
    remainder = rem(integer, output_base)
    do_output([remainder | output], quotient, output_base)
  end
end
