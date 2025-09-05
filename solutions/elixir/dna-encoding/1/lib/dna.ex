defmodule DNA do
  def encode_nucleotide(code_point) do
    cond do
      code_point==?A -> 1
      code_point==?C -> 2
      code_point==?G -> 4
      code_point==?T -> 8
      code_point==?\s -> 0
      true->0
    end
  end

  def decode_nucleotide(encoded_code) do
     cond do
      encoded_code==1 -> ?A
      encoded_code==2 -> ?C
      encoded_code==4 -> ?G
      encoded_code==8 -> ?T
      encoded_code==0 -> ?\s
      true -> 0
    end
  end

  def encode([]), do: <<>>
  def encode([h|t]) do 
    <<encode_nucleotide(h) :: size(4),encode(t)::bitstring>>
  end

  def decode(<<>>), do: []
  def decode(<<h::size(4),rest::bitstring>>) do
     [decode_nucleotide(h)|decode(rest)]
  end
end
