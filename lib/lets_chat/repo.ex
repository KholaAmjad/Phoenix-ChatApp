defmodule LetsChat.Repo do
  use Ecto.Repo,
    otp_app: :lets_chat,
    adapter: Ecto.Adapters.Postgres
end
