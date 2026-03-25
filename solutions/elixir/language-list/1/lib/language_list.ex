defmodule LanguageList do

  @functional_languages ["Clojure", "Haskell", "Erlang", "Elixir", "F#"]
  def new(),  do: []

  def add(list, language), do: [language] ++ list

  def remove([_head | tail]), do: tail

  def first([head | _tail]),  do: head

  def count(list), do: length(list)

  def functional_list?(list) do
    case Enum.filter(list, fn item -> item in @functional_languages end) do
      [] -> false
      _ -> true
    end
  end
end
