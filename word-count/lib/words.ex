defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    String.split(sentence, ~r/[\s_]/)
      |> Enum.reduce(%{}, &collect_word_count(&1, &2))
  end

  defp collect_word_count(word, result) do
    sanitize(word)
      |> update_word_count(result)
  end

  defp sanitize(word) do
    Regex.replace(~r/[[:punct:]]+$/u, word, "")
      |> String.downcase
  end

  defp update_word_count("", result), do: result

  defp update_word_count(word, result) do
    Map.update(result, sanitize(word), 1, &(&1 + 1))
  end
end
