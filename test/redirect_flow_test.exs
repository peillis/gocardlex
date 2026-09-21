defmodule RedirectFlowTest do
  use Gocardlex.ApiCase

  test "create_redirect_flow creates a redirect flow" do
    params = %{
      redirect_flows: %{
        session_token: "SESS_0000000000000000",
        success_redirect_url: "https://mysite.com/redirect_path",
        links: %{creditor: "CR123"}
      }
    }

    redirect_flow = %{
      "id" => "RE123",
      "session_token" => "SESS_0000000000000000"
    }

    expect_request(:post, "/redirect_flows", %{"redirect_flows" => redirect_flow},
      body: params,
      status: 201
    )

    assert {:ok, %{"redirect_flows" => ^redirect_flow}} =
             Gocardlex.Client.create_redirect_flow(params)
  end

  test "get_redirect_flow retrieves a redirect flow" do
    redirect_flow = %{"id" => "RE123"}
    expect_request(:get, "/redirect_flows/RE123", %{"redirect_flows" => redirect_flow})

    assert {:ok, %{"redirect_flows" => ^redirect_flow}} =
             Gocardlex.Client.get_redirect_flow("RE123")
  end
end
