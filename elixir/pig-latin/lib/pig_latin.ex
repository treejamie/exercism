defmodule PigLatin do
  @moduledoc """
  What I learned in this lesson.
  - I have no idea how children can do this on demand.
  - Regex capture group strcuture [full_match | groups ]
  """

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(fn word ->
      word
      # rule 1 - straight swap on vowels
      |> add_ay(~r/^([aeiou]|xr|yt)/)
      # rule 3 - starts with zero or more consonants followed by "qu", move to end, add ay
      |> move_to_end_add_ay(~r/^([^aeiou]*qu)/)
      # rule 4 - ne or more consonants followed by "y", first move the consonants preceding
      # the "y"to the end of the word, and then add an "ay"
      |> move_first_captured_group(~r/^([^aeiouy]+)(y)/)
      # rule 2 - one or more consonants, first move those consonants to the end of the word
      # and then add an "ay"
      |> move_to_end_add_ay(~r/^([^aeiou]+)/)
    end)
    |> Enum.join(" ")
  end

  defp add_ay(phrase, regex) do
    regex
    |> Regex.run(phrase)
    |> case do
      nil -> phrase
      _ -> phrase <> "ay"
    end
  end

  defp move_first_captured_group(phrase, regex) do
    with [_full | [capture | _others]] when capture != nil <- Regex.run(regex, phrase),
         phrase <- String.replace(phrase, capture, "") do
      phrase <> capture <> "ay"
    else
      nil -> phrase
    end
  end

  defp move_to_end_add_ay(phrase, regex) do
    with false <- String.ends_with?(phrase, "ay"),
         [capture] when capture != nil <- Regex.run(regex, phrase, capture: :first),
         phrase <- String.replace(phrase, capture, "") do
      phrase <> capture <> "ay"
    else
      _ -> phrase
    end
  end
end
