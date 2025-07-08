defmodule Gocardlex.Api.BillingRequest do
  import Gocardlex.Utils.Comms

  def create(body) do
    request(:post, "/billing_requests", body)
  end

  def collect_customer_details(billing_request_id, body) do
    request(
      :post,
      "/billing_requests/#{billing_request_id}/actions/collect_customer_details",
      body
    )
  end

  def collect_bank_account(billing_request_id, body) do
    request(:post, "/billing_requests/#{billing_request_id}/actions/collect_bank_account", body)
  end

  def confirm_payer_details(billing_request_id, body \\ %{}) do
    request(:post, "/billing_requests/#{billing_request_id}/actions/confirm_payer_details", body)
  end

  def fulfil(billing_request_id, body \\ %{}) do
    request(:post, "/billing_requests/#{billing_request_id}/actions/fulfil", body)
  end

  def cancel(billing_request_id, body) do
    request(:post, "/billing_requests/#{billing_request_id}/actions/cancel", body)
  end
end
