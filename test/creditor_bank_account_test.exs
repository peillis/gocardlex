defmodule CreditorBankAccountTest do
  use Gocardlex.ApiCase

  test "list_creditor_bank_accounts returns bank accounts" do
    accounts = [%{"id" => "BA123", "enabled" => true}]
    expect_request(:get, "/creditor_bank_accounts", %{"creditor_bank_accounts" => accounts})

    assert {:ok, %{"creditor_bank_accounts" => ^accounts}} =
             Gocardlex.Client.list_creditor_bank_accounts()
  end

  test "create_creditor_bank_account creates an account that can be retrieved" do
    params = %{
      creditor_bank_accounts: %{
        account_holder_name: "John Doe",
        account_number: "55779911",
        branch_code: "200000",
        country_code: "GB",
        links: %{creditor: "CR123"}
      }
    }

    account = %{"id" => "BA123", "account_holder_name" => "JOHN DOE", "enabled" => true}

    expect_request(
      :post,
      "/creditor_bank_accounts",
      %{"creditor_bank_accounts" => account},
      body: params,
      status: 201
    )

    expect_request(:get, "/creditor_bank_accounts/BA123", %{
      "creditor_bank_accounts" => account
    })

    assert {:ok, %{"creditor_bank_accounts" => ^account}} =
             Gocardlex.Client.create_creditor_bank_account(params)

    assert {:ok, %{"creditor_bank_accounts" => ^account}} =
             Gocardlex.Client.get_creditor_bank_account("BA123")
  end

  test "disable_creditor_bank_account disables an account" do
    account = %{"id" => "BA123", "enabled" => false}

    expect_request(
      :post,
      "/creditor_bank_accounts/BA123/actions/disable",
      %{"creditor_bank_accounts" => account},
      body: %{}
    )

    assert {:ok, %{"creditor_bank_accounts" => ^account}} =
             Gocardlex.Client.disable_creditor_bank_account("BA123")
  end
end
