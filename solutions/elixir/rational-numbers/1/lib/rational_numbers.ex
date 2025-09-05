defmodule RationalNumbers do
  @type rational :: {integer, integer}

  def gcd(a, 0) do
    cond do
      a == 0 -> 1
      a > 0 -> a
      a < 0 -> -a
    end
  end

  def absi(a) do
    cond do
      a >= 0 -> a
      a < 0 -> -a
    end
  end

  def gcd(a, b) do
    gcd(b, rem(a, b))
  end

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    c = reduce({elem(a, 0) * elem(b, 1) + elem(b, 0) * elem(a, 1), elem(a, 1) * elem(b, 1)})

    cond do
      elem(c, 0) == 0 -> {0, 1}
      true -> c
    end
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    c = reduce({elem(a, 0) * elem(b, 1) - elem(b, 0) * elem(a, 1), elem(a, 1) * elem(b, 1)})

    cond do
      elem(c, 0) == 0 -> {0, 1}
      true -> c
    end
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    c = reduce(a)
    d = reduce(b)

    cond do
      elem(a, 0) == 0 || elem(b, 0) == 0 -> {0, 1}
      true -> reduce({elem(c, 0) * elem(d, 0), elem(c, 1) * elem(d, 1)})
    end
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(a, b) do
    reduce({elem(a, 0) * elem(b, 1), elem(a, 1) * elem(b, 0)})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    reduce({absi(elem(a, 0)), absi(elem(a, 1))})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) do
    b = reduce(a)
    cond do 
      n==0 -> {1,1}
      n > 0 -> reduce({pow(elem(b, 0), n), pow(elem(b, 1), n)})
      n < 0 -> reduce({pow(elem(b, 1), n), pow(elem(b, 0), n)})
    end
  end

  def pow(a, n) do   
    cond do
      n == 0 -> 1
      n > 0 -> pow(a, n - 1) * a
      n < 0 -> div(pow(a, absi(n - 1)) , a)
    end
  end

  def inv(a) do
    {elem(a,1),elem(a,0)}
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
     :math.pow(x,elem(n,0)/elem(n,1))
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    g = gcd(elem(a, 0), elem(a, 1))

    cond do
      elem(a, 1) > 0 -> {div(elem(a, 0), g), div(elem(a, 1), g)}
      elem(a, 1) < 0 -> {-div(elem(a, 0), g), -div(elem(a, 1), g)}
      elem(a, 0) < 0 && elem(a, 1) < 0 -> {-div(elem(a, 0), g), -div(elem(a, 1), g)}
      true -> a
    end
  end
end
