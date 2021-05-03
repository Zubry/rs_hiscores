defmodule RunescapeHiscores.PlayerConsumer do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {RunescapeHiscores.PlayerProducer, []},
        transformer: {__MODULE__, :transform, []},
        rate_limiting: [
          allowed_messages: 60,
          interval: 60_000
        ]
      ],
      processors: [
        default: [concurrency: 1]
      ]
    )
  end

  @impl true
  def handle_message(:default, message, _context) do
    message
    |> Message.update_data(fn player ->
      with {:ok, hiscores_data} <- RunescapeHiscores.PlayerFetcher.fetch(player) do
        RunescapeHiscores.PlayerStore.insert(player, hiscores_data)
      else
        # There was an error, maybe add code to retry?
        _ -> :error
      end
    end)
  end

  def transform(event, _opts) do
    %Message{
      data: event,
      acknowledger: {__MODULE__, :ack_id, :ack_data}
    }
  end

  def ack(:ack_id, _successful, _failed), do: :ok
end
