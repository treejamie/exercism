defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @colors [
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  ]

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    colors
    |> Enum.map(fn color -> @colors[color] end)
    # we only want the first three in the list
    |> Enum.take(3)
    # convert the list into values we can work with
    |> then(fn [first, second, pow] ->
      value =
        [first, second]
        # convert [2, 2] to 22
        |> Enum.reduce(fn x, acc -> acc * 10 + x end)
        # now do the shenanigans
        |> then(fn value ->
          # build the final value
          value * Integer.pow(10, pow)
        end)

      unit =
        cond do
          pow in [2, 3, 4] -> :kiloohms
          pow in [5, 6, 7] -> :megaohms
          pow in [8, 9, 10] -> :gigaohms
          true -> :ohms
        end

      {value, unit}
    end)
    # now finally normalise value
    |> case do
      {value, :gigaohms = unit} -> {div(value, 1000_000_000), unit}
      {value, :megaohms = unit} -> {div(value, 1000_000), unit}
      {value, :kiloohms = unit} -> {div(value, 1_000), unit}
      {value, :ohms = unit} -> {value, unit}
    end
  end
end
