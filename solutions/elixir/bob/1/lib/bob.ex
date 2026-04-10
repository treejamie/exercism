defmodule Bob do
  @typedoc """
  Intent is an overly engineered solution to decided what intent is being used to
  communicate with Bob, the lackadaisical teenager. We've been there.

  Also, fun with Booleans.
  """
  @type intent :: {shouting? :: boolean, question? :: boolean, silence? :: boolean}

  """

  shouting? question?, _ -> "Calm down, I know what I'm doing!"
  shouting?, _, _ -> "Whoa, chill out!"
  _question? -> "Sure."
  _, _, silence? -> "Fine. Be that way!"
  _, _, _ -> "Whatever."

  """

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input
    |> determine_intent()
    |> case do
      {true, true, _} -> "Calm down, I know what I'm doing!"
      {true, _, _} -> "Whoa, chill out!"
      {_, true, _} -> "Sure."
      {_, _, true} -> "Fine. Be that way!"
      _ -> "Whatever."
    end
  end

  @spec determine_intent(String.t()) :: intent
  defp determine_intent(input) do
    {
      is_shouting?(input),
      is_question?(input),
      is_silence?(input)
    }
  end

  @spec is_silence?(String.t()) :: boolean
  defp is_silence?(input) when input == "", do: true

  defp is_silence?(input) do
    Regex.match?(~r/^\s+$/, input)
  end

  @spec is_shouting?(String.t()) :: boolean
  defp is_shouting?(input) do
    cond do
      # any lower case and we're not shouting
      Regex.match?(~r/\p{Ll}/u, input) -> false
      # but anything that isn't uppercase is also not shouting
      not Regex.match?(~r/\p{Lu}/u, input) -> false
      # ok, we're shouty.
      true -> true
    end
  end

  @spec is_question?(String.t()) :: boolean
  defp is_question?(input) do
    # ends in question mark with any amount of whitespace
    Regex.match?(~r/\?\s*$/, input)
  end
end
