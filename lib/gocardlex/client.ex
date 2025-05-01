defmodule Gocardlex.Client do
  @moduledoc """
  Starts up Gocardlex Client

  Uses `Gocardlex.ClientApi.Customer` and other client APIs
  from `/lib/client_apis/`
  """
  @client_name Gocardlex.Client
  use GenServer
  use Gocardlex.ClientApi.{
    Creditor,
    CreditorBankAccount,
    Customer,
    CustomerBankAccount,
    Event,
    Mandate,
    Payment,
    Payout,
    RedirectFlow,
    Refund,
    Subscription
  }

  def init(state) do
    {:ok, state}
  end

  @doc false
  def start_link(_) do
    initial_state = %{}
    GenServer.start_link(__MODULE__, initial_state, [name: @client_name])
  end
end
