defmodule RunescapeHiscores.PlayerStore do
  @moduledoc"""
  Stores results from the hiscores
  """

  use Agent

  def start_link(initial_value \\ %{}) when is_map(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, fn value -> value end)
  end

  def insert(player, stats) do
    Agent.update(__MODULE__, fn value ->
      Map.put(value, player, stats)
    end)
  end

  def remove(player) do
    Agent.update(__MODULE__, fn value ->
      Map.delete(value, player)
    end)
  end
end
