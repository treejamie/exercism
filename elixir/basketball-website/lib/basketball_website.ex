defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    # split up the path
    tokens =
      path
      |> String.split(".")

    do_extract(data, tokens)
  end

  defp do_extract(data, []), do: data
  defp do_extract(nil, _path), do: nil

  defp do_extract(data, [path | paths]) do
    data
    |> Access.get(path)
    |> do_extract(paths)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
