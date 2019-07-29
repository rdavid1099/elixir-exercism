defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @secrets %{
    0 => "wink",
    1 => "double blink",
    2 => "close your eyes",
    3 => "jump"
  }

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Integer.digits(code, 2)
      |> Enum.reverse
      |> Enum.slice(0..5)
      |> convert_to_secret_handshake
  end

  def convert_to_secret_handshake(bin_list) do
    insert_secret_code(bin_list, {}, 0, Enum.count(bin_list))
      |> Enum.reject(&is_nil/1)
  end

  def insert_secret_code(bin_list, result, n, count) when n == count, do: Tuple.to_list(result)

  def insert_secret_code([1 | bin_tail] = bin_list, result, n, count) do
    if (n == 4) do
      Tuple.to_list(result)
        |> Enum.reverse
    else
      insert_secret_code(bin_tail, Tuple.append(result, @secrets[n]), n + 1, count)
    end
  end

  def insert_secret_code([_ | bin_tail], result, n, count) do
    insert_secret_code(bin_tail, result, n + 1, count)
  end
end
