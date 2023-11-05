defmodule LetsChatWeb.RoomLive.Index do
  use LetsChatWeb, :live_view

  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room: " <> room_id

    if connected?(socket) do
      LetsChatWeb.Endpoint.subscribe(topic)
    end

    {:ok,
     assign(socket,
       room_id: room_id,
       form: to_form(%{}, as: :message),
       topic: topic,
       messages: [],
       username: username()
     )}
  end

  @impl true
  def handle_event("submit_message", %{"message" => message}, socket) do
    message = Map.values(message)

    LetsChatWeb.Endpoint.broadcast(socket.assigns.topic, "new_message", %{
      message: message,
      name: socket.assigns.username
    })

    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "new_message", payload: message}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  defp username() do
    "#{MnemonicSlugs.generate_slug(2)}"
  end
end
