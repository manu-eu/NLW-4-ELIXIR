defmodule Rocketpay.Accounts.Operation do

  alias Ecto.Multi

  alias Rocketpay.Account

  # Executes an operation using the given value to the account with the given id
  def call(%{"id" => id, "value" => value}, operation) do
    account_identifier = account_operation_name(operation)

    Multi.new()
    |> Multi.run(account_identifier, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(operation, fn repo, changes ->
      account = Map.get(changes, account_identifier)

      update_balance(repo, account, value, operation)
    end)
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value, operation) do
    account |> handle_values(value, operation) |> update_account(repo, account)
  end

  defp handle_values(%Account{balance: balance}, value, operation) do
    value |> Decimal.cast() |> handle_cast(balance, operation)
  end

  defp handle_cast({:ok, value}, balance, :deposit), do: Decimal.add(balance, value)
  defp handle_cast({:ok, value}, balance, :withdraw), do: Decimal.sub(balance, value)
  defp handle_cast(:error, _balance, _operation), do: {:error, "Invalid value!"}

  defp update_account({:error, _reason } = error, _repo, _account), do: error
  defp update_account(value, repo, account) do
    params = %{balance: value}

    account |> Account.changeset(params) |> repo.update()
  end

  defp account_operation_name(operation), do: "account_#{Atom.to_string(operation)}" |>String.to_atom()
end
