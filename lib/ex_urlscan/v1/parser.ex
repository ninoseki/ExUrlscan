defmodule ExUrlscan.V1.Parser do
  @doc """
  Parse request parameters for the API.
  """
  def parse_request_params(options) do
    Enum.map(options, fn
      {k, v} when is_list(v) -> {to_string(k), elements_to_string(v)}
      {k, v} -> {to_string(k), to_string(v)}
    end)
  end

  defp elements_to_string(elements) do
    Enum.map_join(elements, ",", &to_string/1)
  end
end
