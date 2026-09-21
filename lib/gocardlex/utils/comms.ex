defmodule Gocardlex.Utils.Comms do
  @api_base Application.compile_env!(:gocardlex, :api_base)
  @api_version Application.compile_env!(:gocardlex, :api_version)
  @access_token Application.compile_env!(:gocardlex, :access_token)

  def request(:get, path) do
    path
    |> api_url
    |> then(&Req.get(client(), url: &1))
    |> get_response
  end

  def request(:post, path, body) do
    path
    |> api_url
    |> then(&Req.post(client(), url: &1, json: body))
    |> get_response
  end

  def request(:put, path, body) do
    path
    |> api_url
    |> then(&Req.put(client(), url: &1, json: body))
    |> get_response
  end

  defp get_response({:ok, resp}) do
    case resp.status do
      x when x in [200, 201, 204] -> {:ok, resp.body}
      _ -> {:error, resp.body}
    end
  end

  defp get_response({:error, err}), do: {:error, err}

  defp api_url(url) do
    String.trim_trailing(@api_base, "/") <> url
  end

  defp client() do
    [
      auth: {:bearer, @access_token},
      headers: [
        {"gocardless-version", @api_version},
        {"accept", "application/json"}
      ]
    ]
    |> Keyword.merge(Application.get_env(:gocardlex, :req_options, []))
    |> Req.new()
  end
end
