defmodule Gocardless.Api.Subscription do
  @moduledoc """
  Functions that map to Subscription endpoints

  Talks to our `Gocardless.Utils.Comms` to do the requests
  """
  import Gocardless.Utils.Comms

  def list(params) do
    url_params = URI.encode_query(params)

    :get
    |> request("/subscriptions?#{url_params}")
  end

  def get(subscription_id) do
    :get
    |> request("/subscriptions/#{subscription_id}")
  end

  def create(body) do
    :post
    |> request("/subscriptions", body)
  end

  def update(subscription_id, body) do
    :put
    |> request("/subscriptions/#{subscription_id}", body)
  end

  def cancel(subscription_id) do
    :post
    |> request("/subscriptions/#{subscription_id}/actions/cancel", %{})
  end
end
