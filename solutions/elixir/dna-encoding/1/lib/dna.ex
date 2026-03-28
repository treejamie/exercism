defmodule DNA do
  def encode_nucleotide(65),  do: 0b0001
  def encode_nucleotide(32),  do: 0b0000
  def encode_nucleotide(67),  do: 0b0010
  def encode_nucleotide(71),  do: 0b0100
  def encode_nucleotide(84),  do: 0b1000

  def decode_nucleotide(0b0001), do: 65
  def decode_nucleotide(0b0000), do: 32
  def decode_nucleotide(0b0010), do: 67
  def decode_nucleotide(0b0100), do: 71
  def decode_nucleotide(0b1000), do: 84

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([first | rest], result) do
     encoded = encode_nucleotide(first)
     do_encode(rest, <<result::bitstring, encoded::4>>)
  end
  defp do_encode([], result), do: result

  def decode(dna), do: do_decode(dna, [])
  
  defp do_decode(<<first::4, rest::bitstring>> , result) do
     decoded = decode_nucleotide(first)
     do_decode(rest, [decoded | result])
  end
  defp do_decode(<<>>, result), do: Enum.reverse(result)
end
