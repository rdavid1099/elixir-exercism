defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep_reduce(list, [], fun, true)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    keep_reduce(list, [], fun, false)
  end

  defp keep_reduce([], result, _, _), do: Enum.reverse(result)

  defp keep_reduce([head | tail], result, fun, keep?) do
    if fun.(head) == keep? do
      keep_reduce(tail, [head | result], fun, keep?)
    else
      keep_reduce(tail, result, fun, keep?)
    end
  end
end
