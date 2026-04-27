defmodule Acronym do
  @moduledoc """
  This is the Acronyn lesson from exercism.

  Things I learned doing completing this exercise:

  * String.split can take a regex
  * if things start getting complicated, you're doing it wrong
  """
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.trim()
    |> String.replace("_", "")
    |> String.split(~r/[ \-]/, trim: true)
    |> Enum.map(fn word ->
      word
      |> String.first()
      |> String.upcase()
    end)
    |> Enum.join()
  end
end
