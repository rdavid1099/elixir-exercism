defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    Enum.reduce(strand, 0, fn strand_nucleotide, result ->
      if strand_nucleotide == nucleotide, do: result + 1, else: result
    end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    initial_count = %{?A => 0, ?C => 0, ?G => 0, ?T => 0}
    Enum.reduce(strand, initial_count, fn strand_nucleotide, result ->
      Map.update!(result, strand_nucleotide, &(&1 + 1))
    end)
  end
end
