defmodule LetsChatWeb.PageLive.Index do
  use LetsChatWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("create_room", _params, socket) do
    {:noreply, push_redirect(socket, to: "/room/new")}
  end

  def handle_event("join_room", _params, socket) do
    {:noreply, push_redirect(socket, to: "/rooms")}
  end
end
