defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real(a) do
    elem(a, 0)
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary(a) do
    elem(a, 1)
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) do
    cond do
      !is_tuple(a) ->
        {a * elem(b, 0), a * elem(b, 1)}

      !is_tuple(b) ->
        {b * elem(a, 0), b * elem(a, 1)}

      true ->
        {elem(a, 0) * elem(b, 0) - elem(a, 1) * elem(b, 1),
         elem(b, 0) * elem(a, 1) + elem(b, 1) * elem(a, 0)}
    end
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) do
    cond do
      !is_tuple(a) -> {a + elem(b, 0), elem(b, 1)}
      !is_tuple(b) -> {elem(a, 0) + b, elem(a, 1)}
      true -> {elem(a, 0) + elem(b, 0), elem(a, 1) + elem(b, 1)}
    end
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) do
    cond do
      !is_tuple(b) -> {elem(a, 0) - b, elem(a, 1)}
      !is_tuple(a) -> {a - elem(b, 0), -elem(b, 1)}
      true -> {elem(a, 0) - elem(b, 0), elem(a, 1) - elem(b, 1)}
    end
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) do
    cond do
      !is_tuple(b) ->
        {elem(a, 0) / b, elem(a, 1) / b}

      !is_tuple(a) ->
        denom = :math.sqrt(elem(b, 0)) + :math.sqrt(elem(b, 1))
        {a * elem(b, 0) / denom, -a * elem(b, 1) / denom}

      true ->
        denom = elem(b, 0) * elem(b, 0) + elem(b, 1) * elem(b, 1)

        {
          (elem(a, 0) * elem(b, 0) + elem(a, 1) * elem(b, 1)) / denom,
          (elem(a, 1) * elem(b, 0) - elem(a, 0) * elem(b, 1)) / denom
        }
    end
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs(a) do
    :math.sqrt(elem(a, 0) * elem(a, 0) + elem(a, 1) * elem(a, 1))
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate(a) do
    {elem(a, 0), -elem(a, 1)}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp(a) do
    {:math.exp(elem(a, 0)) * :math.cos(elem(a, 1)), :math.exp(elem(a, 0)) * :math.sin(elem(a, 1))}
  end
end
