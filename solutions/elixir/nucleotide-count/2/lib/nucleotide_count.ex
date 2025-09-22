defmodule NucleotideCount do
  @nucleotides MapSet.new([?A, ?C, ?G, ?T])

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    cond do
      Enum.member?(@nucleotides,nucleotide) -> Enum.count(strand,fn n -> n==nucleotide end)
      true -> 0
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do 
    Map.merge(@nucleotides |> Enum.into(%{},fn x -> {x,0} end), strand |> Enum.frequencies)
  end
end
