# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LetsChat.Repo.insert!(%LetsChat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

LetsChat.Repo.insert!(%LetsChat.Context.Room{name: "Chat with Me...!"})
