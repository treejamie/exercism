defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @rosetta [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    to_numerals(number, @rosetta, "")
  end

  defp to_numerals(0, _, numerals), do: numerals

  defp to_numerals(number, [{divisor, numeral} | divisors], numerals) do
    case div(number, divisor) do
      0 ->
        to_numerals(number, divisors, numerals)

      qty ->
        to_numerals(
          rem(number, divisor),
          divisors,
          numerals <> String.duplicate(numeral, qty)
        )
    end
  end
end
