defmodule RunescapeHiscores do
  @moduledoc """
  An application that automatically fetches runescape players from the hiscores and stores them locally.
  """
  alias RunescapeHiscores.{PlayerList, PlayerStore}

  def track_player(player) do
    PlayerList.insert(player)
  end

  def untrack_player(player) do
    PlayerList.remove(player)
  end

  def get_player(player) do
    PlayerStore.get(player)
  end
end
