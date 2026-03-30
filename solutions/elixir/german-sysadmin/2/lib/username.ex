defmodule Username do

  def sanitize(username) do
    sanitize(username, ~c"")
  end

  defp sanitize([], sanitized), do: Enum.reverse(sanitized)
  
  defp sanitize([char | rest], sanitized) do

    sanitized_char = 
      case char do
        char when ?ä == char -> ~c"ea"
        char when ?ö == char -> ~c"eo"
        char when ?ü == char -> ~c"eu"
        char when ?ß == char -> ~c"ss"
        char when ?_ == char -> ~c"_"
        char when char >= 97 and char <= 122 -> [char]
        _ -> []
      end
      
    sanitize(rest, sanitized_char ++ sanitized)   

  end
end
