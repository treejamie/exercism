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
    string
    |> String.split("", trim: true)
    |> do_encode(1, "")
  end

  defp do_encode([], _count, results), do: results
  defp do_encode([head], count, results), do: encode_results(results, count, head)

  defp do_encode([head | tail], count, results) do
    if head == List.first(tail) do
      do_encode(tail, count + 1, results)
    else
      do_encode(tail, 1, encode_results(results, count, head))
    end
  end

  defp encode_results(results, count, character) do
    case count do
      1 -> results <> character
      count -> results <> "#{count}#{character}"
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.split(~r/\d+/, string, trim: true, include_captures: true)
    |> Enum.chunk_every(2)
    |> do_decode("")
  end

  defp do_decode([], result), do: result
  defp do_decode([[result]], _result), do: result

  defp do_decode([[qty, chars] | tail], result) do
    # get qty to an int
    qty = parse_int(qty)

    # split chars into a list, get the first one
    result =
      case String.split(chars, "", trim: true) do
        [duplicator] ->
          # build result
          result <> String.duplicate(duplicator, qty)

        [duplicator | rest] ->
          # build result
          result <> String.duplicate(duplicator, qty) <> Enum.join(rest)
      end

    # now recurseer
    do_decode(tail, result)
  end

  defp parse_int(maybe_int?) do
    case Integer.parse(maybe_int?) do
      {int, _} -> int
      :error -> :error
    end
  end
end
