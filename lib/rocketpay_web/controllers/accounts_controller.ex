defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transaction.Response, as: TransactionResponse

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      conn |> put_status(:ok) |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      conn |> put_status(:ok) |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    # The process of do a transaction can be made by a Task.
    # This is how it looks like:
    #
    # - task = Task.async(fn -> Rocketpay.transaction(params) end)
    # - with {:ok, %TransactionResponse{} = transaction} <- Task.await(task) do
    # -   conn |> put_status(:ok) |> render("transaction.json", transaction: transaction)
    # - end
    with {:ok, %TransactionResponse{} = transaction} <- Rocketpay.transaction(params) do
      conn |> put_status(:ok) |> render("transaction.json", transaction: transaction)
    end
  end

end
