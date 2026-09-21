ExUnit.start()

Application.put_env(:gocardlex, :req_options, plug: {Req.Test, Gocardlex})

defmodule Gocardlex.ApiCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case
      import Gocardlex.ApiCase
    end
  end

  setup context do
    Req.Test.set_req_test_to_shared(context)
    Req.Test.verify_on_exit!(context)
    :ok
  end

  def expect_request(method, path, response, options \\ []) do
    query = Keyword.get(options, :query, "")
    expected_body = Keyword.get(options, :body)
    status = Keyword.get(options, :status, 200)

    Req.Test.expect(Gocardlex, fn conn ->
      ExUnit.Assertions.assert(conn.method == method |> Atom.to_string() |> String.upcase())
      ExUnit.Assertions.assert(conn.request_path == path)
      ExUnit.Assertions.assert(conn.query_string == query)
      assert_body(conn, expected_body)

      conn
      |> Plug.Conn.put_status(status)
      |> Req.Test.json(response)
    end)
  end

  defp assert_body(conn, nil) do
    ExUnit.Assertions.assert(Req.Test.raw_body(conn) == "")
  end

  defp assert_body(conn, expected_body) do
    actual = conn |> Req.Test.raw_body() |> IO.iodata_to_binary() |> JSON.decode!()
    expected = expected_body |> JSON.encode!() |> JSON.decode!()
    ExUnit.Assertions.assert(actual == expected)
  end
end
