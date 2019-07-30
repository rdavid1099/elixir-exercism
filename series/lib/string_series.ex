defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size < 1, do: []

  def slices(s, size) do
    if size <= String.length(s) do
      sanitized_size = size - 1
      iterate_n_times(String.length(s) - sanitized_size, s, size)
    else
      []
    end
  end

  defp iterate_n_times(0, _, _, result), do: Enum.reverse(result)

  defp iterate_n_times(n, <<_>> <> tail = str, size, result \\ []) do
    iterate_n_times(n - 1, tail, size, [String.slice(str, 0..size - 1) | result])
  end
end
