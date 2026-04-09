defmodule RationalNumbers do
  @moduledoc """
  A module for performing various mathmatical operations on rational numbers.


  If maths wasn't your background, or it's been ages, you probably experienced
  rational numbers as fractions.

  So if it helps whilst learning: s/rational number/fraction/g

  Finally, the logic has been reduced down into terse mathmatical style operations.
  Sucn things aren't going to get easier if I avoid the,.
  """

  import Kernel, except: [abs: 1]

  @typedoc """
  A rational number has a numerator (n) and denominator (d).
  """
  @type rational :: {n :: integer, d :: integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({n_a, d_a}, {n_b, d_b}), do: reduce({n_a * d_b + n_b * d_a, d_a * d_b})

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({n_a, d_a}, {n_b, d_b}), do: reduce({n_a * d_b - n_b * d_a, d_a * d_b})

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({n_a, d_a}, {n_b, d_b}), do: reduce({n_a * n_b, d_a * d_b})

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({n_a, d_a}, {n_b, d_b}), do: reduce({n_a * d_b, d_a * n_b})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({n, d}) when n < 0 and d < 0, do: {n * -1, d * -1}
  def abs({n, d}) when d < 0, do: {n, d * -1}
  def abs({n, d}) when n < 0, do: {n * -1, d}
  def abs(r), do: reduce(r)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  # Line 93 is great (except the naming), but can be defined easier: reduce{-n, -d})
  def reduce({n, d}) when d < 0, do: reduce({n * -1, d * -1})
  def reduce({a, b}), do: {div(a, Integer.gcd(a, b)), div(b, Integer.gcd(a, b))}

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(_r, n) when n == 0, do: {1, 1}

  #
  # YOU WERE HERE CONTEMPLATING :math.ppw
  #
  def pow_rational(r, n) when n < 0 do
    r
    |> do_pow(n * -1)
    |> then(fn {a, b} -> reduce({b, a}) end)
  end

  def pow_rational(r, n) do
    IO.inspect(r)

    do_pow(r, n)
    |> reduce()
  end

  defp do_pow(r, n) when n < 2, do: r
  defp do_pow(r, n), do: multiply(r, do_pow(r, n - 1))

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a1, a2}), do: :math.pow(x, a1 / a2)
end
