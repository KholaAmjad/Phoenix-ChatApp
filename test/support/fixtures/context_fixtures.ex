defmodule LetsChat.ContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LetsChat.Context` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> LetsChat.Context.create_room()

    room
  end
end
