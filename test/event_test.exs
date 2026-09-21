defmodule EventTest do
  use Gocardlex.ApiCase

  test "list_events returns events" do
    events = [%{"id" => "EV123"}]
    expect_request(:get, "/events", %{"events" => events})

    assert {:ok, %{"events" => ^events}} = Gocardlex.Client.list_events()
  end

  test "get_event retrieves an event" do
    event = %{"id" => "EV123"}
    expect_request(:get, "/events/EV123", %{"events" => event})

    assert {:ok, %{"events" => ^event}} = Gocardlex.Client.get_event("EV123")
  end
end
