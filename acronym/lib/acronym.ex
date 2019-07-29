defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, ~r/[\s-]/)
      |> Enum.reduce("", &get_acronym_letters(&1, &2))
  end

  defp get_acronym_letters(<<first>> <> rest, result) do
    extract_inconsistent_case(rest, result <> String.upcase(<<first>>))
  end

  defp extract_inconsistent_case("", result), do: result

  defp extract_inconsistent_case(<<first>> <> rest, result) do
    if String.match?(<<first>>, ~r/[A-Z]/) do
      extract_inconsistent_case(rest, result <> String.upcase(<<first>>))
    else
      extract_inconsistent_case(rest, result)
    end
  end
end
