defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    [
      # I may be over thinking this.
      "",
      String.split(string, "", trim: true)
    ]
    |> Enum.reduce(fn key, [encoded, decoded] ->
      if String.last(encoded) == key do
      end
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(_string) do
  end
end
