defmodule Ragnarok.Repo do
  use Ecto.Repo,
    otp_app: :ragnarok,
    adapter: Ecto.Adapters.Postgres
end
