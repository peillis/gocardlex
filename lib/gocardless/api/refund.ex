defmodule Gocardlex.Api.Refund do
  import Gocardlex.Utils.Comms

  def list(params) do
    url_params = params |> URI.encode_query

    request(:get, "/refunds?#{url_params}")
  end

  def get(refund_id) do
    request(:get, "/refunds/#{refund_id}")
  end

  def create(body) do
    request(:post, "/refunds", body)
  end

  def update(refund_id, body) do
    request(:put, "/refunds/#{refund_id}", body)
  end
end
