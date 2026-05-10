defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    with :ok <- all_sides_gt_0?(a, b, c),
         :ok <- triangle?(a, b, c),
         type <- triangle_type(a, b, c) do
      {:ok, type}
    else
      error -> error
    end
  end

  defp triangle_type(a, b, c) do
    cond do
      a == b && a == c -> :equilateral
      a == b || a == c || b == c -> :isosceles
      true -> :scalene
    end
  end

  defp triangle?(a, b, c) do
    if a + b >= c && b + c >= a && a + c >= b do
      :ok
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end

  defp all_sides_gt_0?(a, b, c) do
    if a <= 0 || b <= 0 || c <= 0 do
      {:error, "all side lengths must be positive"}
    else
      :ok
    end
  end
end
