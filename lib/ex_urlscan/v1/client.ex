defmodule ExUrlscan.V1.Client do
  @moduledoc """
  Client used for the API interaction
  """

  import ExUrlscan.V1.Base

  alias ExUrlscan.V1.Parser

  @doc """
  Wrapper function for: https://urlscan.io/about-api/#result
  """
  def result(uuid) do
    request(:get, "/result/#{uuid}")
  end

  @doc """
  Wrapper function for: https://urlscan.io/about-api/#result (DOM)
  """
  @spec dom(any) :: {:error, false | nil | true | binary | [any] | number | map} | {:ok, any}
  def dom(uuid) do
    request(:get, "/dom/#{uuid}/")
  end

  @doc """
  Wrapper function for: https://ExUrlscan.io/about-api/#submission
  """
  def scan(url) do
    request(:post, "/scan/", url: url)
  end

  def scan(url, options) do
    params =
      Parser.parse_request_params(
        [url: url] ++ Keyword.take(options, [:customagent, :referer, :public])
      )

    request(:post, "/scan/", params)
  end

  @doc """
  Wrapper function for: https://urlscan.io/about-api/#search
  """
  def search(options) do
    params = Parser.parse_request_params(Keyword.take(options, [:q, :size, :offset, :sort]))
    query_string = URI.encode_www_form(URI.encode_query(params))
    request(:get, "/search/?#{query_string}")
  end
end
