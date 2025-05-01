defmodule Gocardless.Utils.Comms do
  @api_base Application.compile_env!(:gocardless, :api_base)
  @api_version Application.compile_env!(:gocardless, :api_version)
  @access_token Application.compile_env!(:gocardless, :access_token)

  def request(:get, path) do
    path
    |> api_url
    |> then(&Tesla.get(client(), &1))
    |> get_response
  end

  def request(:post, path, body) do
    path
    |> api_url
    |> then(&Tesla.post(client(), &1, body))
    |> get_response
  end

  def request(:put, path, body) do
    path
    |> api_url
    |> then(&Tesla.put(client(), &1, body))
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
    @api_base <> url
  end

  defp client() do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, @api_base},
      {Tesla.Middleware.BearerAuth, token: @access_token},
      {Tesla.Middleware.Headers, [
        {"user-agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"},
        {"authorization", "Bearer #{@access_token}"},
        {"gocardless-version", @api_version},
        {"accepts", "application/json"},
        {"content-type", "application/json"}
      ]},
      Tesla.Middleware.JSON
    ])
  end
end
