defmodule RunescapeHiscores.PlayerProducer do
  @moduledoc"""
  A GenStage producer that produces the next players to fetch from the hiscores
  """

  use GenStage

  def start_link(_args) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    {:producer, RunescapeHiscores.PlayerList.get()}
  end

  def handle_demand(demand, state) when demand > length(state)do
    handle_demand(demand, state ++ RunescapeHiscores.PlayerList.get())
  end

  def handle_demand(demand, state) do
    {to_dispatch, remaining} = Enum.split(state, demand)

    {:noreply, to_dispatch, remaining}
  end
end
