defmodule Sample.Listener do
  use GenServer
  
  def start_link, do: start_link([])
  def start_link(state, _opts \\ []) do
    state = Enum.into(state, %{})
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end
  
  def init(_) do
    try do
      {:ok, Postgrex.Notifications.start_link([
        otp_app: :sample,
        adapter: Ecto.Adapters.Postgres,
        username: "hello",
        password: "world",
        database: "bogus",
        hostname: "localhost",
        port: 16384
      ])}
    rescue
      DBConnection.ConnectionError ->
        {:ok, :error}
    end
  end
end
