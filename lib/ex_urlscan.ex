defmodule ExUrlscan do
  @moduledoc """
  API client for the urlscan.io
  """
  use Application

  def start(_, _) do
    children = [
      ExUrlscan.Configuration
    ]

    opts = [strategy: :one_for_one, name: ExUrlscan.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
