defmodule SubscriptionTest do
  use Gocardlex.ApiCase

  test "list_subscriptions returns subscriptions" do
    subscriptions = [%{"id" => "SB123"}]
    expect_request(:get, "/subscriptions", %{"subscriptions" => subscriptions})

    assert {:ok, %{"subscriptions" => ^subscriptions}} =
             Gocardlex.Client.list_subscriptions()
  end

  test "create_subscription creates a subscription" do
    params = %{
      subscriptions: %{
        amount: "2500",
        currency: "GBP",
        name: "Test Subscription",
        interval_unit: "monthly",
        day_of_month: "1",
        links: %{mandate: "MD123"}
      }
    }

    subscription = %{"id" => "SB123", "name" => "Test Subscription"}

    expect_request(:post, "/subscriptions", %{"subscriptions" => subscription},
      body: params,
      status: 201
    )

    assert {:ok, %{"subscriptions" => ^subscription}} =
             Gocardlex.Client.create_subscription(params)
  end

  test "update_subscription updates a subscription" do
    params = %{subscriptions: %{name: "Updated subscription"}}
    subscription = %{"id" => "SB123", "name" => "Updated subscription"}

    expect_request(:put, "/subscriptions/SB123", %{"subscriptions" => subscription}, body: params)

    assert {:ok, %{"subscriptions" => ^subscription}} =
             Gocardlex.Client.update_subscription("SB123", params)
  end

  test "get_subscription retrieves a subscription" do
    subscription = %{"id" => "SB123"}
    expect_request(:get, "/subscriptions/SB123", %{"subscriptions" => subscription})

    assert {:ok, %{"subscriptions" => ^subscription}} =
             Gocardlex.Client.get_subscription("SB123")
  end

  test "cancel_subscription cancels a subscription" do
    subscription = %{"id" => "SB123", "status" => "cancelled"}

    expect_request(
      :post,
      "/subscriptions/SB123/actions/cancel",
      %{"subscriptions" => subscription},
      body: %{}
    )

    assert {:ok, %{"subscriptions" => ^subscription}} =
             Gocardlex.Client.cancel_subscription("SB123")
  end
end
