defmodule RnaTranscription do
  @map_nuc %{"G"=>"C","C"=>"G","T"=>"A","A"=>"U"}
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
     dna
     |> List.to_string
     |> String.graphemes
     |> Enum.map(fn n -> Map.get(@map_nuc,n) end)
     |> Enum.join
     |> to_charlist
  end
end
