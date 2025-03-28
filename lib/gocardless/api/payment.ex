defmodule Gocardless.Api.Payment do
  import Gocardless.Utils.Comms

  def list(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/payments?#{url_params}")
  end

  def get(payment_id) do
    request(:get, "/payments/#{payment_id}")
  end

  def create(body) do
    request(:post, "/payments", body)
  end

  def update(payment_id, body) do
    request(:put, "/payments/#{payment_id}", body)
  end

  def cancel(payment_id, body) do
    request(:post, "/payments/#{payment_id}/actions/cancel", body)
  end

  def retry(payment_id, body) do
    request(:post, "/payments/#{payment_id}/actions/retry", body)
  end
end
