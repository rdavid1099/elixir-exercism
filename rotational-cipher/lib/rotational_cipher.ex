defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, 0), do: text

  def rotate(text, shift) do
    String.to_charlist(text)
      |> shift_charlist(shift)
  end

  defp shift_charlist(chars, shift) do
    Enum.map(chars, &convert_char(&1, shift))
      |> to_string
  end

  defp convert_char(char, shift) when char >= ?a and char <= ?z do
    get_rotation_value(char, shift, ?a, ?z)
  end

  defp convert_char(char, shift) when char >= ?A and char <= ?Z do
    get_rotation_value(char, shift, ?A, ?Z)
  end

  defp convert_char(char, _), do: char

  defp get_rotation_value(char, shift, a, z) do
    case rem((char + shift), z + 1) do
      remainder when remainder < a -> remainder + a
      remainder -> remainder
    end
  end
end
