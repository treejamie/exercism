defmodule Username do

  def sanitize(username) do
    sanitize(username, ~c"")
  end

  defp sanitize([], sanitized), do: Enum.reverse(sanitized)
  
  defp sanitize([char | rest], sanitized) do

    sanitized_char = 
      case char do
        228 -> [101, 97]
        246 -> [101, 111]
        252 -> [101, 117]
        223 -> [115, 115]
        95 -> [char]
        char when char >= 97 and char <= 122 -> [char]
        _ -> []
      end
      
    sanitize(rest, sanitized_char ++ sanitized)   

  end
end
