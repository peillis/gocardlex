defmodule PayoutTest do
  use Gocardlex.ApiCase

  test "list_payouts returns payouts" do
    payouts = [%{"id" => "PO123"}]
    expect_request(:get, "/payouts", %{"payouts" => payouts})

    assert {:ok, %{"payouts" => ^payouts}} = Gocardlex.Client.list_payouts()
  end

  test "get_payout retrieves a payout" do
    payout = %{"id" => "PO123"}
    expect_request(:get, "/payouts/PO123", %{"payouts" => payout})

    assert {:ok, %{"payouts" => ^payout}} = Gocardlex.Client.get_payout("PO123")
  end
end
