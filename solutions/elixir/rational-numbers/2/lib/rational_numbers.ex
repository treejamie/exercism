defmodule RationalNumbers do
  @moduledoc """
  I found this very, very, very hard.
  """

  import Kernel, except: [abs: 1]

  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, a2}, {b1, b2}) do
    # the "bottom" is simply second ones multiplied
    c2 = a2 * b2

    # the top has two operations
    # first: the first top (a1) multiplied by second bottom (b2)
    c1_1 = a1 * b2
    # second: the second top (b1) multiplied by first bottom (a2)
    c1_2 = b1 * a2
    # c1 is their total
    c1 = c1_1 + c1_2
    
    # done
    reduce({c1, c2})
  end  


  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, a2}, {b1, b2}) do
    # the "bottom" is simply second ones multiplied
    c2 = a2 * b2

    # the top has two operations
    # first: the first top (a1) multiplied by second bottom (b2)
    c1_1 = a1 * b2
    # second: the second top (b1) multiplied by first bottom (a2)
    c1_2 = b1 * a2
    # c1 is their total
    c1 = c1_1 - c1_2
    
    # done
    reduce({c1, c2})
  end


  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, a2}, {b1, b2}) do
    # much easier. 
    reduce({a1 * b1, a2 * b2})
  end



  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, a2}, {b1, b2}) do
    reduce({(a1 * b2), (a2 * b1)})
  end

  
  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) when a < 0 and b < 0,  do: {a * -1, b * -1}
  def abs({a, b}) when b < 0,  do: {a, b * -1}
  def abs({a, b}) when a < 0,  do: {a * -1, b}
  def abs(r), do: reduce(r)


  @spec do_gcd(a :: integer, b:: integer) :: integer
  defp do_gcd(a, 0), do: Kernel.abs(a) 
  defp do_gcd(a, b) do
    do_gcd(b, rem(a, b))
  end


  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) when b < 0, do: reduce({a * -1, b * -1})
  def reduce({a, b}) do
   gcd = do_gcd(a, b)
   {div(a, gcd), div(b, gcd)}
  end



  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(_r, n) when n == 0, do: {1, 1}
  def pow_rational(r, n) when n < 0 do
    {a, b} = do_pow(r, n * -1)
    reduce({b, a})
  end
  def pow_rational(r, n) do
    do_pow(r, n)
    |> reduce()
  end

  defp do_pow(r, n) when n < 2, do: r

  defp do_pow(r, n) do
    multiply(r, do_pow(r, n - 1))
  end


  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a1, a2}) do
    :math.pow(x, a1 / a2)
  end

end
