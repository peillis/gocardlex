defmodule Gocardless.Api.Mandate do
  import Gocardless.Utils.Comms

  def list(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/mandates?#{url_params}")
  end

  def get(mandate_id) do
    request(:get, "/mandates/#{mandate_id}")
  end

  def create(body) do
    request(:post, "/mandates", body)
  end

  def update(mandate_id, body) do
    request(:put, "/mandates/#{mandate_id}", body)
  end

  def cancel(mandate_id) do
    request(:post, "/mandates/#{mandate_id}/actions/cancel", %{})
  end

  def reinstate(mandate_id) do
    request(:post, "/mandates/#{mandate_id}/actions/reinstate", %{})
  end

  def pdf_preview(body) do
    :post
    |> request("/mandate_pdfs", body)
  end
end
