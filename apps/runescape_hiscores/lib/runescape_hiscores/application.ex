defmodule RunescapeHiscores.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {RunescapeHiscores.PlayerList, []},
      {RunescapeHiscores.PlayerProducer, []},
      {RunescapeHiscores.PlayerStore, %{}},
      {RunescapeHiscores.PlayerConsumer, []}
      # Starts a worker by calling: RunescapeHiscores.Worker.start_link(arg)
      # {RunescapeHiscores.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RunescapeHiscores.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
