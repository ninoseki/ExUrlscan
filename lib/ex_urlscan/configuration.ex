defmodule ExUrlscan.Configuration do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def config do
    GenServer.call(__MODULE__, :get) |> Enum.into(%{})
  end

  def reconfigure do
    GenServer.cast(__MODULE__, :reconfigure)
  end

  # Server (callbacks)

  @impl true
  def init(_) do
    config = Application.get_all_env(:ex_urlscan)
    {:ok, config}
  end

  @impl true
  def handle_call(:get, _, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast(:reconfigure, _) do
    state = Application.get_all_env(:ex_urlscan)
    {:noreply, state}
  end
end
