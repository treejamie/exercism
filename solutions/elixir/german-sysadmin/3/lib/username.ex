defmodule Username do

  def sanitize(username) do
    sanitize(username, ~c"")
  end

  defp sanitize([], sanitized), do: Enum.reverse(sanitized)
  
  defp sanitize([char | rest], sanitized) do

    sanitized_char = 
      case char do
        ?ä -> ~c"ea"
        ?ö -> ~c"eo"
        ?ü -> ~c"eu"
        ?ß -> ~c"ss"
        ?_ -> ~c"_"
        char when char >= 97 and char <= 122 -> [char]
        _ -> []
      end
      
    sanitize(rest, sanitized_char ++ sanitized)   

  end
end
