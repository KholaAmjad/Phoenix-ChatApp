defmodule LetsChatWeb.PageLive.Index do
  use LetsChatWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("join_room", _params, socket) do
    random_slug = "/" <> MnemonicSlugs.generate_slug(3)
    {:noreply, push_redirect(socket, to: random_slug)}
  end
end
