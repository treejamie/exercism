defmodule ProteinTranslation do
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => :stop,
    "UAG" => :stop,
    "UGA" => :stop
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    rna
    |> to_charlist()
    |> Enum.chunk_every(3)
    |> Enum.map(&to_string/1)
    |> Enum.reduce_while([], fn codon, acc ->
      case translate_codon(codon) do
        :stop -> {:halt, acc}
        :error -> {:halt, "invalid RNA"}
        protein -> {:cont, [protein | acc]}
      end
    end)
    |> then(fn result ->
      if is_list(result) do
        {:ok, result}
      else
        {:error, result}
      end
    end)
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case translate_codon(codon) do
      :stop -> {:ok, "STOP"}
      :error -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end

  defp translate_codon(codon) do
    case Map.get(@codons, codon) do
      nil -> :error
      protein -> protein
    end
  end
end
