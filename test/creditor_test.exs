defmodule CreditorTest do
  use ExUnit.Case

  test "list_creditors returns response formated as required" do
    {:ok, %{"creditors" => creditors}} = Gocardlex.Client.list_creditors
    assert is_list(creditors)
  end

  test "create_creditor creates a creditor" do
    params = %{
      creditors: %{
        name: "Test Creditor"
      }
    }

    {:ok, %{"creditors" => new_creditor}} = Gocardlex.Client.create_creditor(params)
    {:ok, %{"creditors" => creditor}} = Gocardlex.Client.get_creditor(new_creditor["id"])
    assert creditor["name"] == "Test Creditor"
  end

  test "update_creditor updates a creditor" do
    params = %{
      creditors: %{
        name: "Updated Creditor"
      }
    }

    {:ok, %{"creditors" => updated_creditor}} = get_last_creditor_id()
    |> Gocardlex.Client.update_creditor(params)

    {:ok, %{"creditors" => creditor}} = Gocardlex.Client.get_creditor(updated_creditor["id"])
    assert creditor["name"] == "Updated Creditor"
  end

  defp get_last_creditor_id do
    {:ok, %{"creditors" => creditors}} = Gocardlex.Client.list_creditors(%{limit: 1})
    
    {:ok, creditor} = creditors 
    |> Enum.fetch(-1)

    creditor["id"]
  end
end
