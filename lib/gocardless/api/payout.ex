defmodule Gocardless.Api.Payout do
  @moduledoc """
  Functions that map to Payout endpoints

  Talks to our `Gocardless.Utils.Comms` to do the requests
  """
  import Gocardless.Utils.Comms

  def list(params) do
    url_params = URI.encode_query(params)

    :get
    |> request("/payouts?#{url_params}")
  end

  def get(payout_id) do
    :get
    |> request("/payouts/#{payout_id}")
  end
end
