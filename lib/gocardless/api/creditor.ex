defmodule Gocardless.Api.Creditor do
  import Gocardless.Utils.Comms

  def list(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/creditors?#{url_params}")
  end

  def get(creditor_id) do
    request(:get, "/creditors/#{creditor_id}")
  end

  def create(body) do
    request(:post, "/creditors", body)
  end

  def update(creditor_id, body) do
    request(:put, "/creditors/#{creditor_id}", body)
  end
end
