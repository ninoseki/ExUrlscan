defmodule ExUrlscan.V1.Base do
  @moduledoc """
  Basic HTTP interactions with urlscan.io
  """

  alias ExUrlscan.UrlBuilder

  @endpoint "https://urlscan.io/api/v1"

  def request(method, path) do
    do_request(method, path, "")
  end

  def request(method, path, params) do
    payload =
      params
      |> Map.new()
      |> Poison.encode!()

    do_request(method, path, payload)
  end

  def do_request(type, path, body) do
    url = UrlBuilder.make_url(@endpoint, path)

    headers =
      case type do
        :get -> %{}
        :post -> UrlBuilder.default_headers()
      end

    case HTTPoison.request(type, url, body, headers) do
      {:ok, response} ->
        parse_response(response)

      {:error, reason} ->
        raise(ExUrlscan.ConnectionError, reason: reason)
    end
  end

  defp parse_response(%{status_code: ok, body: body, headers: headers}) when ok in 200..299 do
    header_map = headers |> Map.new()

    gzip? =
      Enum.any?(headers, fn {name, value} -> name == "Content-Encoding" && value == "gzip" end)

    res =
      case header_map do
        %{"Content-Type" => "application/json; charset=utf-8"} ->
          body |> Poison.decode!()

        %{"Content-Type" => "text/plain"} ->
          if gzip? do
            :zlib.gunzip(body)
          else
            body
          end

        _ ->
          body
      end

    {:ok, res}
  end

  defp parse_response(%{status_code: ok, body: body}) when ok in 400..499 do
    res =
      body
      |> Poison.decode!()

    {:error, res}
  end
end
