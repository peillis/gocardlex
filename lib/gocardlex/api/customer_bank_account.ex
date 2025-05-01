defmodule Gocardlex.Api.CustomerBankAccount do
  import Gocardlex.Utils.Comms

  def list(params) do
    url_params = params |> URI.encode_query

    request(:get, "/customer_bank_accounts?#{url_params}")
  end

  def get(customer_bank_account_id) do
    request(:get, "/customer_bank_accounts/#{customer_bank_account_id}")
  end

  def create(body) do
    request(:post, "/customer_bank_accounts", body)
  end

  def update(customer_bank_account_id, body) do
    request(:put, "/customer_bank_accounts/#{customer_bank_account_id}", body)
  end

  def disable(customer_bank_account_id) do
    request(:post, "/customer_bank_accounts/#{customer_bank_account_id}/actions/disable", %{})
  end
end