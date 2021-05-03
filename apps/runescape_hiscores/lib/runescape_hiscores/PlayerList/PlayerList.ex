defmodule RunescapeHiscores.PlayerList do
  @moduledoc"""
  Stores a list of players that can be fetched from the hiscores API
  """

  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> MapSet.new(initial_value) end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, fn value -> Enum.to_list(value) end)
  end

  def insert(player) do
    Agent.update(__MODULE__, fn value ->
      MapSet.put(value, player)
    end)
  end

  def remove(player) do
    Agent.update(__MODULE__, fn value ->
      MapSet.delete(value, player)
    end)
  end
end
