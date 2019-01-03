defmodule ExUrlscan.UrlBuilder do
  @doc """
  A module builds urls for the API
  """
  alias ExUrlscan.Configuration

  def make_url(endpoint, path) do
    endpoint <> path
  end

  def default_headers do
    api_key = Configuration.config()[:api_key]

    if api_key == nil do
      raise "Application key is not configured. Please provide the api_key in one of the ways described in the documentation."
    end

    [
      {"API-Key", api_key},
      {"Content-Type", "application/json"}
    ]
  end
end
