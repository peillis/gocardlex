defmodule Gocardless do
  @moduledoc false
  use Application

  def start(_type, _args) do
    Supervisor.start_link([
      {Gocardless.Client, []}
    ], strategy: :one_for_one, name: GoCardless.Supervisor)
  end
end
