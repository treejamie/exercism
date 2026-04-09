defmodule RationalNumbers do
  @moduledoc """
  A module for performing various mathmatical operations on rational numbers.

  If maths wasn't your background, or it's been ages, you probably experienced
  rational numbers as fractions.  So if it helps whilst learning: s/rational number/fraction/g

  The logic has been reduced down into terse mathmatical style operations in this iteration.
  Such things aren't going to get easier if I avoid them,
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
  def reduce({n, d}) when d < 0, do: reduce({n * -1, d * -1})
  def reduce({a, b}), do: {div(a, Integer.gcd(a, b)), div(b, Integer.gcd(a, b))}

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, exp :: integer) :: rational
  def pow_rational(_r, n) when n == 0, do: {1, 1}

  def pow_rational({n, d}, exp) when exp > 0,
    do: reduce({Integer.pow(n, exp), Integer.pow(d, exp)})

  def pow_rational({n, d}, exp), do: reduce({Integer.pow(d, -exp), Integer.pow(n, -exp)})

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a1, a2}), do: :math.pow(x, a1 / a2)
end
