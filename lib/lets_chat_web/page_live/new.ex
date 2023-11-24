defmodule LetsChatWeb.PageLive.New do
  use LetsChatWeb, :live_view
  alias LetsChat.Context.Room
  alias LetsChat.Context

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(Context.change_room(%Room{})))}
  end

  @impl true
  def handle_params(_params, _url, socket) do

    changeset = Context.change_room(%Room{})

    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("validate", %{"room" => params}, socket) do
    form =
      %Room{}
      |> Context.change_room(params)
      |> Map.put(:action, :insert)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("save", %{"room" => params}, socket) do
    case Context.create_room(params) do
      {:ok, room} ->
        {:noreply, push_redirect(socket, to: "/room/#{room.id}")}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
