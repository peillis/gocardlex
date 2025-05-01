defmodule Gocardlex do
  @moduledoc false
  use Application

  def start(_type, _args) do
    Supervisor.start_link([
      {Gocardlex.Client, []}
    ], strategy: :one_for_one, name: Gocardlex.Supervisor)
  end
end
