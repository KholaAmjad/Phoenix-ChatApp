defmodule LetsChatWeb.RoomLive.Rooms do
  use LetsChatWeb, :live_view
  alias LetsChat.Context

  @impl true
  def mount(_params, _session, socket) do
    rooms = Context.list_rooms()
    {:ok, assign(socket, rooms: rooms)}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <.header>
      Ongoing Rooms
      </.header>
       <.table id="rooms" rows={@rooms}>
       <:col :let={room} label="Name"><%= room.name %></:col>
       <:col :let={room} ><button class="btn-tertiary" phx-click="join" phx-value-room_id={room.id}> Join </button></:col>
       <:col :let={room} ><button class="btn-tertiary" phx-click="delete" phx-value-room_id={room.id}> Delete </button></:col>
       </.table>
    """
  end

  @impl true
  def handle_event("join", %{"room_id" => room_id}, socket) do
    {:noreply, push_redirect(socket, to: "/room/#{room_id}")}
  end

  def handle_event("delete", %{"room_id" => room_id}, socket) do
    params = Context.get_room!(room_id)
    case Context.delete_room(params) do
      {:ok, _room} ->
        {:noreply, push_redirect(socket, to: "/rooms")}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
