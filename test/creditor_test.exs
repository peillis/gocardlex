defmodule CreditorTest do
  use Gocardlex.ApiCase

  test "list_creditors returns creditors" do
    expect_request(:get, "/creditors", %{"creditors" => [%{"id" => "CR123"}]})

    assert {:ok, %{"creditors" => [%{"id" => "CR123"}]}} =
             Gocardlex.Client.list_creditors()
  end

  test "create_creditor creates a creditor that can be retrieved" do
    params = %{creditors: %{name: "Test Creditor"}}
    creditor = %{"id" => "CR123", "name" => "Test Creditor"}

    expect_request(:post, "/creditors", %{"creditors" => creditor},
      body: params,
      status: 201
    )

    expect_request(:get, "/creditors/CR123", %{"creditors" => creditor})

    assert {:ok, %{"creditors" => ^creditor}} = Gocardlex.Client.create_creditor(params)
    assert {:ok, %{"creditors" => ^creditor}} = Gocardlex.Client.get_creditor("CR123")
  end

  test "update_creditor updates a creditor" do
    params = %{creditors: %{name: "Updated Creditor"}}
    creditor = %{"id" => "CR123", "name" => "Updated Creditor"}

    expect_request(:put, "/creditors/CR123", %{"creditors" => creditor}, body: params)

    assert {:ok, %{"creditors" => ^creditor}} =
             Gocardlex.Client.update_creditor("CR123", params)
  end
end
