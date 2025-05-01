defmodule Gocardless.Api.RedirectFlow do
  @moduledoc """
  Functions that map to Redirect Flow endpoints

  Talks to our `Gocardless.Utils.Comms` to do the requests
  """
  import Gocardless.Utils.Comms

  def get(redirect_flow_id) do
    :get
    |> request("/redirect_flows/#{redirect_flow_id}")
  end

  def create(body) do
    :post
    |> request("/redirect_flows", body)
  end

  def complete(redirect_flow_id, body) do
    :post
    |> request("/redirect_flows/#{redirect_flow_id}/actions/complete", body)
  end
end
