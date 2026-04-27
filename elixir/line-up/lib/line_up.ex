defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) when rem(number, 100) in [11, 12, 13], do: message(name, number, "th")
  def format(name, number) when rem(number, 10) in [11, 12, 13], do: message(name, number, "th")
  def format(name, number) when rem(number, 10) == 1, do: message(name, number, "st")
  def format(name, number) when rem(number, 10) == 2, do: message(name, number, "nd")
  def format(name, number) when rem(number, 10) == 3, do: message(name, number, "rd")
  def format(name, number), do: message(name, number, "th")

  defp message(name, number, suffix),
    do: "#{name}, you are the #{number}#{suffix} customer we serve today. Thank you!"
end
