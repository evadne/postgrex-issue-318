defmodule Sample.Application do
  use Application
  def start(_type, _args) do
    import Supervisor.Spec
    children = [worker(Sample.Listener, [])]
    opts = [strategy: :one_for_one, name: Sample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
