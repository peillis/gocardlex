defmodule Gocardlex.Api.Customer do
  import Gocardlex.Utils.Comms

  def list(params \\ %{}) do
    url_params = params |> URI.encode_query

    request(:get, "/customers?#{url_params}")
  end

  def get(customer_id) do
    request(:get, "/customers/#{customer_id}")
  end

  def create(body) do
    request(:post, "/customers", body)
  end

  def update(customer_id, body) do
    request(:put, "/customers/#{customer_id}", body)
  end
end
