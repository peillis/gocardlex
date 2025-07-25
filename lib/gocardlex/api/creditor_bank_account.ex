defmodule Gocardlex.Api.CreditorBankAccount do
  @moduledoc false

  import Gocardlex.Utils.Comms

  def list(params \\ %{}) do
    url_params = URI.encode_query(params)

    :get
    |> request("/creditor_bank_accounts?#{url_params}")
  end

  def get(creditor_bank_account_id) do
    :get
    |> request("/creditor_bank_accounts/#{creditor_bank_account_id}")
  end

  def create(body) do
    :post
    |> request("/creditor_bank_accounts", body)
  end

  def disable(creditor_bank_account_id) do
    :post
    |> request("/creditor_bank_accounts/#{creditor_bank_account_id}/actions/disable", %{})
  end
end
