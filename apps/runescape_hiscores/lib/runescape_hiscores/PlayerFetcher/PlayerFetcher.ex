defmodule RunescapeHiscores.PlayerFetcher do
  @moduledoc """
  Loads the given player from the hiscores
  """
  require Logger

  # opts is currently ignored, but may be used in the future
  def fetch(player, _opts \\ []) do
    player
    |> generate_url
    |> HTTPoison.get()
    |> handle_response(player)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}, player) do
    Logger.info("Successfully loaded #{player}")

    {:ok, body
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row, ",") end)
    }
  end

  defp handle_response(_, player) do
    Logger.warn("Failed to load #{player}")

    :error
  end

  defp generate_url(player) do
    "https://secure.runescape.com/m=hiscore_oldschool/index_lite.ws?player=#{player}"
  end
end
