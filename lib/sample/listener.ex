defmodule Sample.Listener do
  use GenServer
  
  def start_link, do: start_link([])
  def start_link(state, _opts \\ []) do
    state = Enum.into(state, %{})
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end
  
  def init(_) do
    Process.flag(:trap_exit, true)
    Process.send_after(self(), :attempt_connect, 500)
    {:ok, :pending}
  end
  
  def handle_info(:attempt_connect, state) do
    config = [
      otp_app: :sample,
      adapter: Ecto.Adapters.Postgres,
      username: "hello",
      password: "world",
      database: "bogus",
      hostname: "localhost",
      port: 16384,
      sync_connect: true
    ]
    case Postgrex.Notifications.start_link(config) do
      {:ok, pid} -> {:noreply, pid}
      {:error, reason} ->
        IO.inspect [:attempt_connect, reason]
        Process.send_after(self(), :attempt_connect, 500)
        {:noreply, :error}
    end
  end

  def handle_info(_, :error), do: {:noreply, :error} 
  def handle_info({:EXIT, pid, reason}, pid) do
    Process.send_after(self(), :attempt_connect, 500)
    {:noreply, :error}
  end
end
