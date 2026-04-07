defmodule Chessboard do
  def rank_range, do: 1..8

  def file_range, do: 65..72

  def ranks, do: rank_range() |> Enum.map(& &1)

  def files, do: file_range() |> Enum.map(&<<&1>>)
end
