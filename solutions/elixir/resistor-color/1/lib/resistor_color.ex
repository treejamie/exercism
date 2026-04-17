defmodule ResistorColor do
  @doc """
  Return the value of a color band
  """
  @colours [
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
  @spec code(colour :: atom) :: integer()
  def code(colour) do
    case Keyword.get(@colours, colour) do
      nil -> {:error, :unknown_resistor}
      colour -> colour
    end
  end
end
