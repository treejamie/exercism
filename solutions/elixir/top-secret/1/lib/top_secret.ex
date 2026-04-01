defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part(ast, acc) do
    case extract_name_and_arity(ast) do
      nil ->
        {ast, acc}

      {name, arity} ->
        {ast, List.insert_at(acc, 0, String.slice(name, 0, arity))}
    end
  end

  defp extract_name_and_arity({operator, _, [{:when, _, [{name, _, args} | _]} | _]})
       when operator in [:defp, :def] and is_list(args) do
    {
      Atom.to_string(name),
      length(args)
    }
  end

  defp extract_name_and_arity({operator, _, [{name, _, args}, _]})
       when operator in [:defp, :def] and is_list(args) do
    {
      Atom.to_string(name),
      length(args)
    }
  end

  defp extract_name_and_arity({operator, _, [{name, _, _} | _]})
       when operator in [:defp, :def] do
    {
      Atom.to_string(name),
      0
    }
  end

  defp extract_name_and_arity(_), do: nil

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> then(fn {_ast, message_list} ->
      message_list
      |> Enum.reverse()
      |> Enum.join()
    end)
  end
end
