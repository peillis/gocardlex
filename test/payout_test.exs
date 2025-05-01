defmodule PayoutTest do
  use ExUnit.Case

  test "list_payouts/1 returns response formated as required" do
    prepare_test()
    {:ok, %{"payouts" => payouts}} = Gocardlex.Client.list_payouts
    assert is_list(payouts)
  end

  test "get_payout/1 returns a payout" do
    prepare_test()

    {:ok, %{"payouts" => payouts}} = Gocardlex.Client.list_payouts

    {:ok, payout} = Enum.fetch(payouts, -1)

    {:ok, %{"payouts" => retrieved_payout}} = Gocardlex.Client.get_payout(payout["id"])

    assert retrieved_payout["id"] == payout["id"]
  end

  defp prepare_test do
    params = %{
      creditors: %{name: "Test Creditor"}
    }
    {:ok, %{"creditors" => new_creditor}} = Gocardlex.Client.create_creditor(params)

    params = %{
      customers: %{
        email: "name@email.com",
        given_name: "Success",
        family_name: "Lastname",
        country_code: "GB"
      }
    }

    {:ok, %{"customers" => new_customer}} = Gocardlex.Client.create_customer(params)

    params = %{
      customer_bank_accounts: %{
        account_holder_name: "FirstName LastName",
        account_number: "55779911",
        branch_code: "200000",
        country_code: "GB",
        links: %{customer: new_customer["id"]}
      }
    }

    {:ok, %{"customer_bank_accounts" => new_customer_bank_account}} = Gocardlex.Client.create_customer_bank_account(params)

    params = %{
      mandates: %{
        scheme: "bacs",
        links: %{customer_bank_account: new_customer_bank_account["id"], creditor: new_creditor["id"]}
      }
    }
    {:ok, %{"mandates" => new_mandate}} = Gocardlex.Client.create_mandate(params)

    params = %{
      payments: %{
        amount: 100,
        currency: "GBP",
        charge_date: "2017-06-30",
        links: %{
          mandate: new_mandate["id"]
        }
      }
    }
    Gocardlex.Client.create_payment(params)
  end
end
