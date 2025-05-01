defmodule Gocardlex.Api.Event do
  @moduledoc """
  Functions that map to Event endpoints

  Talks to our `Gocardlex.Utils.Comms` to do the requests
  """
  import Gocardlex.Utils.Comms

  def list(params) do
    url_params = URI.encode_query(params)

    :get
    |> request("/events?#{url_params}")
  end

  def get(event_id) do
    :get
    |> request("/events/#{event_id}")
  end
end
