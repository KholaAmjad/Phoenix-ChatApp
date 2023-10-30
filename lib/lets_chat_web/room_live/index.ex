defmodule LetsChatWeb.RoomLive.Index do
  use LetsChatWeb, :live_view

  @impl true
  def mount(%{"id" => room_id}, _session, socket) do
    topic = "room: " <> room_id
    LetsChatWeb.Endpoint.subscribe(topic)
    {:ok, assign(socket, room_id: room_id, form: to_form(%{}, as: :message), topic: topic, messages: ["A user joined chat"])}
  end

  def handle_event("submit_message", %{"message" => message}, socket) do
    message = Map.values(message)
    updated_messages = socket.assigns.messages ++ [message]
    LetsChatWeb.Endpoint.broadcast(socket.assigns.topic, "new_message", message)
    {:noreply, assign(socket, messages: updated_messages)}
  end

  def handle_info(%{event: "new_message", payload: message}, socket) do
    {:noreply, socket}
  end
end
