defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) when rna == "", do: {:ok, []}
  def of_rna(rna) when byte_size(rna) <= 3, do: {:error, "invalid RNA"}

  def of_rna(rna) do
    result =
      String.graphemes(rna)
      |> Enum.chunk_every(3)
      |> Enum.map(fn chunk -> Enum.join(chunk) end)
      |> Enum.map(fn chunk -> of_codon(chunk) end)
      |> Enum.map(fn {_, codon} -> codon end)
      |> Enum.take_while(fn c -> c != "STOP" end)

    cond do
      Enum.any?(result, fn s -> s == "invalid codon" end) ->
        {:error, "invalid RNA"}

      true ->
        {:ok, result}
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  strand = "UUCUUCUAAUGGU"
  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case codon do
      "UGU" -> {:ok, "Cysteine"}
      "UGC" -> {:ok, "Cysteine"}
      "UUA" -> {:ok, "Leucine"}
      "UUG" -> {:ok, "Leucine"}
      "AUG" -> {:ok, "Methionine"}
      "UUU" -> {:ok, "Phenylalanine"}
      "UUC" -> {:ok, "Phenylalanine"}
      "UCU" -> {:ok, "Serine"}
      "UCC" -> {:ok, "Serine"}
      "UCA" -> {:ok, "Serine"}
      "UCG" -> {:ok, "Serine"}
      "UGG" -> {:ok, "Tryptophan"}
      "UAU" -> {:ok, "Tyrosine"}
      "UAC" -> {:ok, "Tyrosine"}
      "UAA" -> {:ok, "STOP"}
      "UAG" -> {:ok, "STOP"}
      "UGA" -> {:ok, "STOP"}
      "" -> {:ok, []}
      _ -> {:error, "invalid codon"}
    end
  end
end
